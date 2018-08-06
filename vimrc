set nocompatible              " be iMproved, required
filetype off                  " required

"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')


"" Plugins
"" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"" vim-autoread plugin: https://github.com/djoshea/vim-autoread
Plugin 'djoshea/vim-autoread'

Plugin 'Yggdroot/indentLine'

"" https://github.com/ctrlpvim/ctrlp.vim
Plugin 'ctrlpvim/ctrlp.vim'

"" https://github.com/vim-airline/vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"" https://github.com/Valloric/YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

"" https://github.com/scrooloose/syntastic
Plugin 'scrooloose/syntastic'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

"" ShowMarks plugin
"Plugin 'ShowMarks'

"" vim-signature
Plugin 'kshenoy/vim-signature'


Plugin 'vim-scripts/Conque-GDB'

Plugin 'tpope/vim-fugitive'

Plugin 'mhinz/vim-startify'

Plugin 'christoomey/vim-tmux-navigator'


"" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"" To ignore plugin indent changes, instead use:
"filetype plugin on
""
"" Brief help
"" :PluginList       - lists configured plugins
"" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
""
"" see :h vundle for more details or wiki for FAQ
"" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" indent settings
"" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "" Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    "" Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

"" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
" Still it is a \t. It is just that
" Vim will interpret it to be having
" a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

""indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '┆'

"" set auto wrap
set wrap


"" buffer settings
"" edit multiple buffers without saving the modifications
set hidden
"nnoremap <C-N> :bnext<CR>
"nnoremap <C-P> :bprev<CR>

"" In insert mode, ctrl u will delete the current line, ctrl w will delete the word before the cursor. YOU CAN NOT UNDO THESE DELETIONS!
"" With the following changes, you can undo the deletions made by the ctrl u and ctrl w by first press Esc to return to normal mode, then press u to undo.
"" For more reference, please refer to http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>


"" set mapleader
let mapleader=","

"" completion Options for Omni completion
set completeopt=longest,menu

"" allow backspacing over everthing in insert mode
set backspace=indent,eol,start

"" show the cursor position all the time
set ruler
"" display incomplete commands
set showcmd
"" show line numbers
set nu
syntax on

"" highlights the search pattern, and unsets the "last search pattern" register by hitting return
set hlsearch
nnoremap <CR> :noh<CR><CR>
"" increase the number of history
if &history < 1000
    set history=1000
endif

"" Ignore compiled files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*~,*.pyc
"" Set ignore for ctrlp
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }

"" Height of the command bar
" set cmdheight=2

"" For regular expressions turn magic on
set magic

""
"autocmd FileType cpp set keywordprg=cppman

"command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
"autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Visual mode pressing * or # searches for the current selection
"" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Smart way to move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

"" map + _ to resize windows
map + +
map _ -
map > >
map < <



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! VisualSelection(direction) range
    let l:saved_reg=@"
    execute "normal! vgvy"

    let l:pattern=escape(@",'\\/.*$^~[]')
    let l:pattern=substitute(l:pattern,"\n$","","")

    if a:direction=='b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction=='gv'
        "call CmdLine("vimgrep " . '/' . l:pattern . '/' . ' **/*.')
        execute "vimgrep " . '/' . l:pattern . '/' . ' **/*'
    elseif a:direction=='replace'
        call CmdLine("%s" . '/' . l:pattern . '/')
        ""	execute "%s" . '/' . l:pattern . '/'

    elseif a:direction=='f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/=l:pattern
    let @"=l:saved_reg
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" " Always show the status line
"set laststatus=2
"
""" Format the status line ?????statusline
""set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"" ????????$HOME???~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
"" This function only returns the last directory
""function! CurDir()
""    let curdir = substitute(getcwd(), "^\/[a-zA-Z0-9\/-]*\/","", "g")
""    return curdir
""endfunction
"
"set statusline=\ %{HasPaste()}%t%m%r%h[%n]\ %w\ \ \ CWD:\ %r%{CurDir()}%h\ \ \
"            \ Line:\ %l\ [%L]
""set statusline+=%2*\[%n]
"set statusline+=%0*\ \ Col:\ %03c
"set statusline+=%0*\ %w\ %P\
"set statusline+=%0*\ %{&ff}\
""set statusline+=%0*\ %y
"set statusline+=%0*\ %{''.(&fenc!=''?&fenc:&enc).''}
""set statusline+=%0*\ %{(&bomb?\",BOM\":\"\")}\
""set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)\
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" settings for vim-airline
let g:airline_theme='papercolor'
"" open the buffer list at the top
let g:airline#extensions#tabline#enabled = 1
"" append file path
"let g:airline_section_c = '%-0.20{CurDir()}/%t'
"let g:airline_section_c='%{HasPaste()}%{CurDir()}%t%m%r%h[%n]%w'


"" settings for YCM
let g:ycm_global_ycm_extra_conf = '/home/yumiaohust/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'


"" settings for syntastic
let g:ycm_show_diagnostics_ui = 0
let g:syntastic_error_symbol="✗"
let g:syntastic_warning_symbol="!"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes':   [],'passive_filetypes': [] }
noremap <C-w>e :SyntasticCheck<CR>
noremap <C-w>f :SyntasticToggleMode<CR>


"" settings for NERDTree
"" open a NERDTree automatically when vim stars up if no files were specified
"autocmd StdinReadPre * let s:std_in=0
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" close NERDTree automatically
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

"" settings for NERDTree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

"" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

"" settings for ctags
"" Designate the tag files for search, if mulitples tag files are used, add
"" the follows: set tags+= tags1
set tags=tags;
"set autochdir
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope configure
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif


"" Quickfix settings
"" automatically open the location/quickfix window after :make, :grep, :lvimgrep and friends if there are valid locations/errors
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 8
augroup END
"" Use F9 to toggle quickfix window rapidly: NOT WORKING
"noremap <F9> :call asyncrun#quickfix_toggle(8)<cr>


"" when open the file, redirect to the last modified location
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"" :make short cuts
"" Save and make current file.o
"function! Make()
"  let curr_dir = expand('%:h')
"  if curr_dir == ''
"    let curr_dir = '.'
"  endif
"  echo curr_dir
"  execute 'lcd ' . curr_dir
"  execute 'make %:r.o'
"  execute 'lcd -'
"endfunction
"nnoremap <F7> :update<CR>:call Make()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ShowMarks configure
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:showmarks_enable=1
"let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"let g:showmarks_ignore_type="hqm"
"let g:showmarks_hlline_lower=1
"let g:showmarks_hlline_upper=1


"" Conque GDB
let g:ConqueTerm_StartMessages=0
let g:ConqueGdb_SrcSplit='above'
let g:ConqueGdb_SaveHistory=1
let g:ConqueGdb_Leader='\'
let g:ConqueTerm_CloseOnEnd=1

"" vim-fugitive
autocmd QuickFixCmdPost *grep* cwindow

" gvim font settings
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 14
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

