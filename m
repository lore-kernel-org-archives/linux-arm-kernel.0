From: marex@denx.de (Marek Vasut)
Date: Mon, 7 May 2012 18:11:22 +0200
Subject: [PATCH 3/3] ARM: mxs: always build in device tree support
In-Reply-To: <1336399890-12883-4-git-send-email-shawn.guo@linaro.org>
References: <1336399890-12883-1-git-send-email-shawn.guo@linaro.org>
 <1336399890-12883-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <201205071811.22147.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> As the ultimate for mxs platform is to convert over to device tree,
> let's start always building in device tree support for the platform.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  arch/arm/Kconfig               |    1 +
>  arch/arm/configs/mxs_defconfig |    1 +
>  arch/arm/mach-mxs/Kconfig      |    1 -
>  3 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c516baf..ca434ed 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -471,6 +471,7 @@ config ARCH_MXS
>  	select COMMON_CLK
>  	select HAVE_CLK_PREPARE
>  	select PINCTRL
> +	select USE_OF
>  	help
>  	  Support for Freescale MXS-based family of processors
> 
> diff --git a/arch/arm/configs/mxs_defconfig
> b/arch/arm/configs/mxs_defconfig index 1ebbf45..5406c23 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -22,6 +22,7 @@ CONFIG_BLK_DEV_INTEGRITY=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
>  CONFIG_ARCH_MXS=y
> +CONFIG_MACH_MXS_DT=y
>  CONFIG_MACH_MX23EVK=y
>  CONFIG_MACH_MX28EVK=y
>  CONFIG_MACH_STMP378X_DEVB=y
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 8138a13..91cf062 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -25,7 +25,6 @@ config MACH_MXS_DT
>  	bool "Support MXS platforms from device tree"
>  	select SOC_IMX23
>  	select SOC_IMX28
> -	select USE_OF
>  	help
>  	  Include support for Freescale MXS platforms(i.MX23 and i.MX28)
>  	  using the device tree for discovery

Best regards,
Marek Vasut
