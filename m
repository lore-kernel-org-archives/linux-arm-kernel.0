From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 29 Sep 2010 10:30:21 +0900
Subject: [PATCH v2 3/3] ARM: S5PC100/S5PC110/S5PC210: Selete PLAT_S5P at
	each ARCH_S5P series
In-Reply-To: <20100929003913.GA499@july>
References: <20100929003913.GA499@july>
Message-ID: <011701cb5f75$e8770e40$b9652ac0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> As it's default configuration for each SoC, Move to the machine config.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/Kconfig              |    3 +++
>  arch/arm/mach-s5pc100/Kconfig |    1 -
>  arch/arm/mach-s5pv210/Kconfig |    1 -
>  arch/arm/mach-s5pv310/Kconfig |    1 -
>  4 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d10099d..4da2d18 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -711,6 +711,7 @@ config ARCH_S5PC100
>  	select HAVE_S3C2410_I2C
>  	select HAVE_S3C_RTC
>  	select HAVE_S3C2410_WATCHDOG
> +	select PLAT_S5P
>  	help
>  	  Samsung S5PC100 series based systems
> 
> @@ -725,6 +726,7 @@ config ARCH_S5PV210
>  	select HAVE_S3C2410_I2C
>  	select HAVE_S3C_RTC
>  	select HAVE_S3C2410_WATCHDOG
> +	select PLAT_S5P
>  	help
>  	  Samsung S5PV210/S5PC110 series based systems
> 
> @@ -735,6 +737,7 @@ config ARCH_S5PV310
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select GENERIC_CLOCKEVENTS
> +	select PLAT_S5P
>  	help
>  	  Samsung S5PV310 series based systems
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index 77ae4bf..b8fbf2f 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -9,7 +9,6 @@ if ARCH_S5PC100
> 
>  config CPU_S5PC100
>  	bool
> -	select PLAT_S5P
>  	select S5P_EXT_INT
>  	select S3C_PL330_DMA
>  	help
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 97e4f11..6ddc232 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -11,7 +11,6 @@ if ARCH_S5PV210
> 
>  config CPU_S5PV210
>  	bool
> -	select PLAT_S5P
>  	select S3C_PL330_DMA
>  	select S5P_EXT_INT
>  	help
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index ec8b350..4839fef 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -11,7 +11,6 @@ if ARCH_S5PV310
> 
>  config CPU_S5PV310
>  	bool
> -	select PLAT_S5P
>  	help
>  	  Enable S5PV310 CPU support
> 
> --

Yes, you're right.
But just removing 'select PLAT_S5P' from each CPU_S5PXXXX is enough.
Because PLAT_S5P is selected if select ARCH_S5PXXXX in the plat-s5p/Kconfig

So no need to add 'select PLAT_S5P' into ARCH_S5PXXXX config.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
