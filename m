From: jean.pihet@linaro.org (Jean Pihet)
Date: Fri, 26 Sep 2014 20:42:37 +0200
Subject: perf tool failing to build for ARM
In-Reply-To: <20140926162530.GB11361@arm.com>
References: <20140926162530.GB11361@arm.com>
Message-ID: <CAFrcx1nPuJ6TKtBC-eH-hq4bLk4-JPKNGH6ON0ZUB78v4tSh7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 26 September 2014 18:25, Will Deacon <will.deacon@arm.com> wrote:
> Hi Jean,
>
> I'm getting the following error trying to build perf tool for ARM with
> a 3.17-rc6 kernel:
>
>
> arch/arm/util/unwind-libunwind.c: In function ?libunwind__arch_reg_id?:
> arch/arm/util/unwind-libunwind.c:43:3: error: implicit declaration of function ?pr_err? [-Werror=implicit-function-declaration]
>    pr_err("unwind: invalid reg id %d\n", regnum);
>    ^
> arch/arm/util/unwind-libunwind.c:43:3: error: nested extern declaration of ?pr_err? [-Werror=nested-externs]
>   CC       arch/arm/tests/regs_load.o
>   CC       arch/arm/tests/dwarf-unwind.o
> cc1: all warnings being treated as errors
> Makefile.perf:655: recipe for target 'arch/arm/util/unwind-libunwind.o' failed
> make[1]: *** [arch/arm/util/unwind-libunwind.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC       util/probe-finder.o
> arch/arm/tests/dwarf-unwind.c: In function ?sample_ustack?:
> arch/arm/tests/dwarf-unwind.c:20:3: error: implicit declaration of function ?pr_debug? [-Werror=implicit-function-declaration]
>    pr_debug("failed to allocate sample uregs data\n");
>    ^
> arch/arm/tests/dwarf-unwind.c:20:3: error: nested extern declaration of ?pr_debug? [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> Makefile.perf:655: recipe for target 'arch/arm/tests/dwarf-unwind.o' failed
> make[1]: *** [arch/arm/tests/dwarf-unwind.o] Error 1
> Makefile:68: recipe for target 'all' failed
> make: *** [all] Error 2
>
>
> Can you take a look please?

The fix for that error is already in the tip tree at
http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=29a3ce31c38c8f73f4e076b7ffc0876b4f5dd6c3.

Please confirm if this fixes it for you.

Cheers,
Jean

>
>
> Will
