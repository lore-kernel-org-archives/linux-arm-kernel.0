From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 15 Feb 2016 20:26:02 +0900
Subject: [PATCH] ARM: remove 'i' and 'zi' targets
In-Reply-To: <1454839003-4342-1-git-send-email-yamada.masahiro@socionext.com>
References: <1454839003-4342-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASDxBT8J3A70STLCedQTXiwfK+vxo7OVJAgUUORT=pqJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-07 18:56 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> These two were introduced by commit 13d5fadf45d1 ("[ARM] Make 'i' and
> 'zi' targets work") to short-circuit the dependencies for 'install'
> and 'zinstall'.
>
> After that, commit 19514fc665ff ('arm, kbuild: make "make install"
> not depend on vmlinux') eventually made "make (z)install" equivalent
> to "make (z)i".
>
> It is true that 'i' and 'zi' might be still useful as shorthands
> but the original intention had been already lost.
>
> They do not even show up in "make ARCH=arm help", so I hope this
> deletion does not have much impact.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/Makefile      | 1 -
>  arch/arm/boot/Makefile | 8 --------
>  2 files changed, 9 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index cd21135..1e83a45 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -353,7 +353,6 @@ archclean:
>
>  # My testing targets (bypasses dependencies)
>  bp:;   $(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/bootpImage
> -i zi:; $(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
>
>
>  define archhelp
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index ba73a20..48fab15 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -107,12 +107,4 @@ uinstall:
>         $(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
>         $(obj)/uImage System.map "$(INSTALL_PATH)"
>
> -zi:
> -       $(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
> -       $(obj)/zImage System.map "$(INSTALL_PATH)"
> -
> -i:
> -       $(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
> -       $(obj)/Image System.map "$(INSTALL_PATH)"
> -
>  subdir-            := bootp compressed dts
> --


If there is no objection to this patch,
I will put it into Russell's patch tracker.





-- 
Best Regards
Masahiro Yamada
