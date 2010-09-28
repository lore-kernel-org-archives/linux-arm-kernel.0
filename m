From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 20:06:11 +0900
Subject: [PATCH 1/2] ARM: Samsung: S5PC110: Place the common SPARSEMEM at
	CPU_S5PV210
In-Reply-To: <20100927084827.GA3055@july>
References: <20100927084827.GA3055@july>
Message-ID: <007e01cb5efd$2b7e37a0$827aa6e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> In case of s5pc110 CPU. It uses the SPARSEMEN as default memory

Sparsemem?

> configuration.
> So move to CPU_S5PV210 config.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index d3a3895..c361349 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -14,6 +14,7 @@ config CPU_S5PV210
>  	select PLAT_S5P
>  	select S3C_PL330_DMA
>  	select S5P_EXT_INT
> +	select ARCH_SPARSEMEM_ENABLE

I think, should being in the ARCH_S5PV210 not here.
Your other patch, same.

>  	help
>  	  Enable S5PV210 CPU support
> 
> @@ -63,7 +64,6 @@ menu "S5PC110 Machines"
>  config MACH_AQUILA
>  	bool "Aquila"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_FB
>  	select S5P_DEV_FIMC0
>  	select S5P_DEV_FIMC1
> @@ -80,7 +80,6 @@ config MACH_AQUILA
>  config MACH_GONI
>  	bool "GONI"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_FB
>  	select S5P_DEV_FIMC0
>  	select S5P_DEV_FIMC1
> @@ -98,7 +97,6 @@ config MACH_GONI
>  config MACH_SMDKC110
>  	bool "SMDKC110"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_I2C1
>  	select S3C_DEV_I2C2
>  	select S3C_DEV_RTC
> @@ -118,7 +116,6 @@ menu "S5PV210 Machines"
>  config MACH_SMDKV210
>  	bool "SMDKV210"
>  	select CPU_S5PV210
> -	select ARCH_SPARSEMEM_ENABLE
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_HSMMC2
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
