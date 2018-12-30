set encoding=utf-8
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/



" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!


" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.

let mapleader = "\<Space>"
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin


" All of your Plugins must be added before the following line

set shortmess=atI
syntax on
set cursorline
set autoread

highlight CursorLine   cterm=NONE ctermbg=DarkGray ctermfg=NONE guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=DarkGray ctermfg=NONE guibg=NONE guifg=NONE

" 检测文件类型
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" 取消备份。 视情况自己改
set nobackup
" 关闭交换文件
set noswapfile

set wildignore=*.swp,*.bak,*.pyc,*.class,.svn

" 去掉输入错误的提示声音
set noerrorbells

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=12

" 显示行号
set number

"自动保存
let autosave=60

" 设置文内智能搜索提示
" 高亮search命中的文本
set hlsearch

map <C-a> :nohl<cr>

" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

noremap f  i
"映射上下左右的光标移动
noremap i  k
noremap k  j
noremap j  h

"行光标移动
nmap 9 $

nnoremap <Leader>m :w<CR>

vmap <Leader>y "+yy
nmap <Leader>y "+yy
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
nmap <Leader><Leader> V
noremap gV `[v`]
noremap hh G
map <f4> :tabnew .<CR>
nmap <D-j> :e<CR>

"C，C++ 按F5编译运行
map <D-r> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'go'
        exec "!go run %"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" install bundles
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
elseif filereadable(expand("~/.config/nvim/vimrc.bundles")) " neovim
    source ~/.config/nvim/vimrc.bundles
endif

" ensure ftdetect et al work by including this after the bundle stuff
filetype plugin indent on

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=

set mouse=a

"修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" 缩进配置
" Smart indent
set smartindent
" 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent

" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py,*.c exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        " call setline(1, "\#!/usr/bin/env python")
        " call append(1, "\# encoding: utf-8")
        call setline(1, "\# -*- coding: utf-8 -*-")
    endif

    "如果文件为cpp
    if &filetype == 'cpp'
        call setline(1, "#include <iostream>")
        call setline(2, "#include <stdlib.h>")
        call setline(3, "     ")
        call setline(4, "/**")
        call setline(5, " * Author : EssExx")
        call setline(6, " *")
        call setline(7, " */")
        call setline(8, "     ")
        call setline(9, "     ")
        call setline(10, "int main(void)")
        call setline(11, "{")
        call setline(12, "    s")
        call setline(13,  "}")
    endif

    "如果文件为c
    if &filetype == 'c'
        call setline(1, "#include <stdio.h>")
        call setline(2, "#include <stdlib.h>")
        call setline(3, "     ")
        call setline(4, "/**")
        call setline(5, " * Author : EssExx")
        call setline(6, " *")
        call setline(7, " */")
        call setline(8, "     ")
        call setline(9, "     ")
        call setline(10, "int main(void)")
        call setline(11, "{")
        call setline(12, "    s")
        call setline(13,  "}")
    endif

    normal G
    normal o
    normal o
endfunc

"set guifont=Menlo\ 18

" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline


" Enable folding
" set foldmethod=manual
" set foldlevel=99
" autocmd FileType c set foldmethod=syntax
" nnoremap <space> za
setlocal foldmethod=syntax



noremap <C-w> :Autoformat<CR>



set guifont=Menlo:h17

if has('gui_running')
    set guioptions-=T  " no toolbar
    colorscheme onedark
    set linespace=5
endif


set guioptions=
set hidden " 避免必须保存修改才可以跳转buffer

let macvim_skip_cmd_opt_movement = 1
map <M-RIGHT> :bn!<CR>
map <M-LEFT> :bp!<CR>
" buffer快速导航
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>n :bn<CR>

" 查看buffers
nnoremap <Leader>l :ls<CR>

" 通过索引快速跳转
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

inoremap <c-j> <left>
inoremap <c-l> <right>
inoremap <c-k> <c-o>gj
inoremap <c-i> <c-o>gk

" Quit visual mode
vnoremap v <Esc>

" Move to the start of line
nnoremap <Leader>j  ^

" Move to the end of line
nnoremap <Leader>l $

" Redo
nnoremap U <C-r>

" Yank to the end of line
nnoremap Y y$

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>






onoremap p i(

:imap ñ <ESC>

set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码

set foldclose=all          " 设置为自动关闭折叠

"<leader>cc 注释当前行
"<leader>cm 只用一组符号来注释
"<leader>cy 注释并复制
"<leader>cs 优美的注释
"<leader>cu 取消注释

nmap <Space>8 cf(

