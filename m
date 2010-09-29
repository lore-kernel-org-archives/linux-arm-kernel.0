From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 29 Sep 2010 10:24:57 +0900
Subject: [PATCH v2 2/3] ARM: S5PC210: Place the common SPARSEMEM at
	ARCH_S5PV310
In-Reply-To: <20100929003907.GA495@july>
References: <20100929003907.GA495@july>
Message-ID: <010201cb5f75$24c42dc0$6e4c8940$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> In case of s5pc210 CPU. It uses the SPARSEMEM as default memory
> configuration
> So move to ARCH_S5PV310 config.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/Kconfig              |    1 +
>  arch/arm/mach-s5pv310/Kconfig |    2 --
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e112987..d10099d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -731,6 +731,7 @@ config ARCH_S5PV210
>  config ARCH_S5PV310
>  	bool "Samsung S5PV310/S5PC210"
>  	select CPU_V7
> +	select ARCH_SPARSEMEM_ENABLE
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select GENERIC_CLOCKEVENTS
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index 331b5bd..ec8b350 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -30,14 +30,12 @@ config S5PV310_SETUP_I2C2
>  config MACH_SMDKV310
>  	bool "SMDKV310"
>  	select CPU_S5PV310
> -	select ARCH_SPARSEMEM_ENABLE
>  	help
>  	  Machine support for Samsung SMDKV310
> 
>  config MACH_UNIVERSAL_C210
>  	bool "Mobile UNIVERSAL_C210 Board"
>  	select CPU_S5PV310
> -	select ARCH_SPARSEMEM_ENABLE
>  	help
>  	  Machine support for Samsung Mobile Universal S5PC210 Reference
>  	  Board. S5PC210(MCP) is one of package option of S5PV310
> --

Ok..will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
