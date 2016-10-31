From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Oct 2016 22:15:39 +0900
Subject: [PATCH] ARM: mediatek: clean up mach-mediatek/Makefile
In-Reply-To: <1474222273-23116-1-git-send-email-yamada.masahiro@socionext.com>
References: <1474222273-23116-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQbaQ38RZqgmJJW+BHOthrK5tPZ5JPPh9N9ry58YZ=kdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,


Can you pick up this for your next pull request?



2016-09-19 3:11 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Kbuild descends into arch/arm/mach-mediatek/Makefile only when
> CONFIG_ARCH_MEDIATEK is enabled.  So, obj-$(CONFIG_ARCH_MEDIATEK)
> is always equivalent to obj-y in this Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-mediatek/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 2116460..dadae67 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -1,4 +1,2 @@
> -ifeq ($(CONFIG_SMP),y)
> -obj-$(CONFIG_ARCH_MEDIATEK) += platsmp.o
> -endif
> -obj-$(CONFIG_ARCH_MEDIATEK) += mediatek.o
> +obj-$(CONFIG_SMP)      += platsmp.o
> +obj-y                  += mediatek.o
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
