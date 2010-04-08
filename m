From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Apr 2010 09:59:36 +0200
Subject: [PATCH] ARM: S5P: Add System Timer
In-Reply-To: <1269916185-30533-1-git-send-email-kgene.kim@samsung.com>
References: <1269916185-30533-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <001b01cad6f1$71bdd890$553989b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, March 30, 2010 4:30 AM Kukjin Kim wrote:

> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> This patch addes system timer for Samsung S5P series SoCs
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

I've tested this patch on Samsung Aquila board and it works fine.

> ...

> diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
> index a278832..22ed209 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> @@ -94,5 +94,5 @@ MACHINE_START(SMDKV210, "SMDKV210")
>  	.init_irq	= s5pv210_init_irq,
>  	.map_io		= smdkv210_map_io,
>  	.init_machine	= smdkv210_machine_init,
> -	.timer		= &s3c24xx_timer,
> +	.timer		= &s5p_systimer,
>  MACHINE_END

What about mach-smdkc110.c ?

> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index d400a6a..a73fc56 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -23,3 +23,10 @@ config PLAT_S5P
>  	select SAMSUNG_IRQ_UART
>  	help
>  	  Base platform code for Samsung's S5P series SoC.
> +
> +config SYSTIMER_S5P
> +	bool
> +	depends on (ARCH_S5P6442 || ARCH_S5PV210)
> +	default y
> +	help
> +	  Support System Timer for S5P Series

IMHO 'S5P_SYSTIMER' would be a better name, but it is only a matter
of taste.

A new Kconfig option to conditionally disable plat-samsung/time.c timer
build would be nice to disable unused code on S5PV210.

> ...

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
