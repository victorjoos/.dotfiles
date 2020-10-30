" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
let mapleader=" "
let g:mapleader=" "

" starting Plug plugin manager
filetype off

" download plug if not already the case
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'		        " Git wrapper
Plug 'tpope/vim-surround'               " change parentheses
Plug 'tpope/vim-vinegar'                " dir improvements
Plug 'tomtom/tcomment_vim'              " comment and uncomment lines
Plug 'mhinz/vim-startify'               " start-screen
if has("gui_running")
    " Plug 'Valloric/YoucompleteMe', {'do': './install.py --js-completer --rust-completer --java-completer'} " Auto-complete
    " Plug 'rdnetto/YCM-Generator'            " flag generator for YouCompleteMe
endif
Plug 'flazz/vim-colorschemes'	        " Colorscheme package
Plug 'chriskempson/base16-vim'          " Base16 Colorscheme
" Plug 'scrooloose/nerdtree'		        " NerdTree -> file manager
Plug 'ctrlpvim/ctrlp.vim'			    " Fuzzy file searching

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'		    " vim fancy --insert-- bar
Plug 'majutsushi/tagbar'		        " tagbar for c
Plug 'SirVer/ultisnips'		            " TextMate-like snippets
Plug 'honza/vim-snippets'		        " Default snippets
Plug 'rbonvall/snipmate-snippets-bib'   " Snippets for bibTeX
Plug 'dag/vim2hs'                       " haskell for everything
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'rust-lang/rust.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'maxbrunsfeld/vim-yankstack'      " add emacs like yank stack
Plug 'metakirby5/codi.vim'             " scratchpad
Plug 'mustache/vim-mustache-handlebars'
Plug 'cespare/vim-toml'
Plug 'jimenezrick/vimerl'
Plug 'brgmnn/vim-opencl'                " opencl syntax
Plug 'chrisbra/csv.vim'
" Plug 'ctjhoa/spacevim'                  " same keybindings as spacemacs

call plug#end()
" end of Plug

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10.5

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set nobackup		" don't keep a backup file
endif
set history=100		" keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu    " better suggestions
set incsearch   " do incremental searching
set autochdir   " set dir to file

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    set t_Co=256
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        " autocmd BufReadPost *
        "             \ if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$") |
        "             \   exe "normal! g`\"" |
        "             \ endif

    augroup END
    
    autocmd StdinReadPre * let s:std_in=1
    autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

syntax enable
set number
" set relativenumber
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab
let c_no_comment_fold = 1
let c_no_if0_fold = 1
set foldnestmax=1
map <F7> mzgg=G`z<CR>
map j gj
map k gk

inoremap jk <Esc>
inoremap <silent> <S-Space> <C-j>
vnoremap <C-c> "+y

set autowrite " saves automatically on buffer change
set shortmess=a " write more abbreviations on messages
set pastetoggle=<F2>
set clipboard=unnamedplus " use default clipboard
" silent! map <F3> :NERDTreeToggle<CR>
silent! map <Leader>d :NERDTreeToggle<CR>
silent! map <Leader>t :TagbarOpenAutoClose<CR>
runtime ftplugin/man.vim
" autocmd InsertEnter * :set norelativenumber
" autocmd InsertLeave * :set relativenumber
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:UltiSnipsExpandTrigger="<F3>"
" let g:UltiSnipsListSnippets="<C-Tab><C-Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_cache_omnifunc = 0 " don't cache autocomplete
let g:ycm_confirm_extra_conf = 0
let g:ctrlp_map = '<Leader>p'

" let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " powerline always enabled
let g:airline_powerline_fonts = 1 " for terminal fonts

" set list listchars=tab:»·,trail:·
set lazyredraw
set splitright
set splitbelow
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
set foldlevel=99
let g:startify_custom_header = 'startify#fortune#boxed()'
