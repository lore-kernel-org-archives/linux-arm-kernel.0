From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 13:46:20 +0200
Subject: [PATCH 08/17] ARM: S5PC100: no more support S5PC100 SoC
In-Reply-To: <1404210076-2362-2-git-send-email-kgene.kim@samsung.com>
References: <1404210076-2362-1-git-send-email-kgene.kim@samsung.com>
 <1404210076-2362-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <5806444.UHVgoFeOY3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 19:21:16 Kukjin Kim wrote:
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -15,7 +15,7 @@ config PLAT_SAMSUNG
>  
>  config PLAT_S5P
>         bool
> -       depends on (ARCH_S5PC100 || ARCH_S5PV210)
> +       depends on ARCH_S5PV210
>         default y
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_VIC
> @@ -78,14 +78,14 @@ config SAMSUNG_CLKSRC
>           used by newer systems such as the S3C64XX.
>  
>  config S5P_CLOCK
> -       def_bool (ARCH_S5PC100 || ARCH_S5PV210)
> +       def_bool ARCH_S5PV210
>         help
>           Support common clock part for ARCH_S5P and ARCH_EXYNOS SoCs
>  
>  # options for IRQ support
>  
>  config S5P_IRQ
> -       def_bool (ARCH_S5PC100 || ARCH_S5PV210)
> +       def_bool ARCH_S5PV210
>         help
>           Support common interrupt part for ARCH_S5P SoCs
>  
> @@ -142,7 +142,7 @@ config S3C_GPIO_TRACK
>  
>  config S5P_DEV_UART
>         def_bool y
> -       depends on (ARCH_S5PC100 || ARCH_S5PV210)
> +       depends on ARCH_S5PV210
>  
>  # ADC driver
>  

I guess the next logical step would be to either remove these entirely
after the move to DT-only ARCH_S5PV210 obsoletes them, or to move the
code back to mach-s5pv210, right?

 
>  config SAMSUNG_DMADEV
>        bool "Use legacy Samsung DMA abstraction"
> -       depends on CPU_S5PV210 || CPU_S5PC100 || ARCH_S3C64XX
> +       depends on CPU_S5PV210 || ARCH_S3C64XX
>         select DMADEVICES
>         default y
>        help

It would be good to just kill this one off now, as nothing uses it
any more, but that's also a separate patch.

	Arnd
