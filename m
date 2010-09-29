From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 29 Sep 2010 10:24:12 +0900
Subject: [PATCH v2 1/3] ARM: S5PC110: Place the common SPARSEMEM at
	ARCH_S5PV210
In-Reply-To: <20100929003901.GA491@july>
References: <20100929003901.GA491@july>
Message-ID: <010101cb5f75$09ecd740$1dc685c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> In case of s5pc110 CPU. It uses the SPARSEMEM as default memory
> configuration.
> So move to ARCH_S5PV210 config.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/Kconfig              |    1 +
>  arch/arm/mach-s5pv210/Kconfig |    4 ----
>  2 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 553b7cf..e112987 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -717,6 +717,7 @@ config ARCH_S5PC100
>  config ARCH_S5PV210
>  	bool "Samsung S5PV210/S5PC110"
>  	select CPU_V7
> +	select ARCH_SPARSEMEM_ENABLE
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select ARM_L1_CACHE_SHIFT_6
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index d3a3895..97e4f11 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -63,7 +63,6 @@ menu "S5PC110 Machines"
>  config MACH_AQUILA
>  	bool "Aquila"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_FB
>  	select S5P_DEV_FIMC0
>  	select S5P_DEV_FIMC1
> @@ -80,7 +79,6 @@ config MACH_AQUILA
>  config MACH_GONI
>  	bool "GONI"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_FB
>  	select S5P_DEV_FIMC0
>  	select S5P_DEV_FIMC1
> @@ -98,7 +96,6 @@ config MACH_GONI
>  config MACH_SMDKC110
>  	bool "SMDKC110"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_I2C1
>  	select S3C_DEV_I2C2
>  	select S3C_DEV_RTC
> @@ -118,7 +115,6 @@ menu "S5PV210 Machines"
>  config MACH_SMDKV210
>  	bool "SMDKV210"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_HSMMC2
> --

Looks ok to me..will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
