From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 29 Oct 2018 22:05:44 +0900
Subject: [PATCH v3 3/4] ARM: mm: fix build error in fix_to_virt with
 CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
In-Reply-To: <20181028130945.23581-4-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-4-changbin.du@gmail.com>
Message-ID: <CAK7LNAQP6SgtbYcxZ7ApGg006omEZErNcDAVtPR=2RibxN8Ruw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2018 at 10:13 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> With '-Og' optimization level, GCC would not optimize a count for a loop
> as a constant value. But BUILD_BUG_ON() only accept compile-time constant
> values. Let's use __fix_to_virt() to avoid the error.
>
> arch/arm/mm/mmu.o: In function `fix_to_virt':
> /home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
> Makefile:1051: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Applied to linux-kbuild





-- 
Best Regards
Masahiro Yamada
