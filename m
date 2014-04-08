From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Apr 2014 13:02:33 +0200
Subject: [PATCH v2 03/12] ARM: hisi: add ARCH_HISI
In-Reply-To: <1396944052-9887-4-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <6382257.n5Y3c6scoz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 April 2014 16:00:43 Haojian Zhuang wrote:
> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index feee4db..da16efd 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -1,8 +1,16 @@
> -config ARCH_HI3xxx
> -       bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
> +config ARCH_HISI
> +       bool "Hisilicon SoC Support"
> +       depends on ARCH_MULTIPLATFORM
>         select ARM_AMBA
>         select ARM_GIC
>         select ARM_TIMER_SP804
> +
> +if ARCH_HISI
> +
> +menu "Hisilicon platform type"
> +
> +config ARCH_HI3xxx
> +       bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
>         select CACHE_L2X0
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
> @@ -10,3 +18,7 @@ config ARCH_HI3xxx
>         select PINCTRL_SINGLE
>         help
>           Support for Hisilicon Hi36xx/Hi37xx processor family
> +
> +endmenu
> +
> +endif

I'd rather keep them as separate top-level options. The two platforms
are not really related technically, other than being designed by the
same company. Also, I'd prefer the use of 'menuconfig' here, like:

menuconfig ARCH_HI3xxx
	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7

if ARCH_HI3xxx

...

endif


menuconfig ARCH_HIP04
	bool "Hisilicon HiP04 family" if ARCH_MULTI_V7_LPAE

if ARCH_HIP04

...

endif


	Arnd
