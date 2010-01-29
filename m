From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 03:51:32 +0000
Subject: [PATCH v2 4/7] ARM: S5P6442: Update Kconfig and Makefiles
In-Reply-To: <1264730784-16061-1-git-send-email-kgene.kim@samsung.com>
References: <1264730784-16061-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100129035132.GB390@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 11:06:24AM +0900, Kukjin Kim wrote:
> Updates arch/arm Kconfig and Makefile for building the S5P6442 support.
> Also modifies the plat-s5p Kconfig file to include the support for plat-s5p
> for S5P6442.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig          |   12 +++++++++++-
>  arch/arm/Makefile         |    1 +
>  arch/arm/plat-s5p/Kconfig |    2 +-
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3bc5169..a3b0551 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -641,6 +641,14 @@ config ARCH_S5P6440
>  	help
>  	  Samsung S5P6440 CPU based systems
>  
> +config ARCH_S5P6442
> +	bool "Samsung S5P6442"
> +	select CPU_V6
> +	select GENERIC_GPIO
> +	select HAVE_CLK
> +	help
> +	  Samsung S5P6442 CPU based systems
> +
>  config ARCH_S5PC1XX
>  	bool "Samsung S5PC1XX"
>  	select GENERIC_GPIO
> @@ -805,6 +813,8 @@ endif
>  
>  source "arch/arm/mach-s5p6440/Kconfig"
>  
> +source "arch/arm/mach-s5p6442/Kconfig"
> +
>  source "arch/arm/plat-stmp3xxx/Kconfig"
>  
>  if ARCH_S5PC1XX
> @@ -1085,7 +1095,7 @@ source kernel/Kconfig.preempt
>  config HZ
>  	int
>  	default 128 if ARCH_L7200
> -	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440
> +	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440 || ARCH_S5P6442
>  	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
>  	default AT91_TIMER_HZ if ARCH_AT91
>  	default 100
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index bbcd512..553fe62 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -162,6 +162,7 @@ machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c24
>  machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
>  machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
>  machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
> +machine-$(CONFIG_ARCH_S5P6442)		:= s5p6442
>  machine-$(CONFIG_ARCH_S5PC1XX)		:= s5pc100
>  machine-$(CONFIG_ARCH_SA1100)		:= sa1100
>  machine-$(CONFIG_ARCH_SHARK)		:= shark
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index fca6dad..2151949 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -7,7 +7,7 @@
>  
>  config PLAT_S5P
>  	bool
> -	depends on ARCH_S5P6440
> +	depends on (ARCH_S5P6440 || ARCH_S5P6442)

Think we should probably turn this aorund into a select from
each ARCH. This however can be left until later.

>  	default y
>  	select PLAT_S3C
>  	select ARM_VIC
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
