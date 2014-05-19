From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 13:23:59 +0800
Subject: [PATCH 1/2] ARM: i.MX: Open "Device tree only" Kconfig chapter
 for non-V7 CPUs
In-Reply-To: <1400088614-27280-1-git-send-email-shc_work@mail.ru>
References: <1400088614-27280-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140519052358.GG10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 09:30:13PM +0400, Alexander Shiyan wrote:
> This patch allows to add support for other (non-V7) CPUs into
> "Device tree only" Kconfig chapter.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Let's do that when there are actually non-V7 platforms that become
device tree only?

Shawn

> ---
>  arch/arm/mach-imx/Kconfig | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index d56eb1a..29433e7 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -742,23 +742,25 @@ config MACH_EUKREA_MBIMXSD51_BASEBOARD
>  
>  endchoice
>  
> +endif
> +
>  comment "Device tree only"
>  
> -config	SOC_IMX50
> +config SOC_IMX50
>  	bool "i.MX50 support"
> +	depends on ARCH_MULTI_V7
>  	select HAVE_IMX_SRC
>  	select PINCTRL_IMX50
>  	select SOC_IMX5
> -
>  	help
>  	  This enables support for Freescale i.MX50 processor.
>  
> -config	SOC_IMX53
> +config SOC_IMX53
>  	bool "i.MX53 support"
> +	depends on ARCH_MULTI_V7
>  	select HAVE_IMX_SRC
>  	select PINCTRL_IMX53
>  	select SOC_IMX5
> -
>  	help
>  	  This enables support for Freescale i.MX53 processor.
>  
> @@ -778,6 +780,7 @@ config SOC_IMX6
>  
>  config SOC_IMX6Q
>  	bool "i.MX6 Quad/DualLite support"
> +	depends on ARCH_MULTI_V7
>  	select ARM_ERRATA_764369 if SMP
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
> @@ -785,32 +788,29 @@ config SOC_IMX6Q
>  	select PCI_DOMAINS if PCI
>  	select PINCTRL_IMX6Q
>  	select SOC_IMX6
> -
>  	help
>  	  This enables support for Freescale i.MX6 Quad processor.
>  
>  config SOC_IMX6SL
>  	bool "i.MX6 SoloLite support"
> +	depends on ARCH_MULTI_V7
>  	select PINCTRL_IMX6SL
>  	select SOC_IMX6
> -
>  	help
>  	  This enables support for Freescale i.MX6 SoloLite processor.
>  
>  config SOC_VF610
>  	bool "Vybrid Family VF610 support"
> +	depends on ARCH_MULTI_V7
>  	select ARM_GIC
>  	select PINCTRL_VF610
>  	select VF_PIT_TIMER
>  	select PL310_ERRATA_588369 if CACHE_PL310
>  	select PL310_ERRATA_727915 if CACHE_PL310
>  	select PL310_ERRATA_769419 if CACHE_PL310
> -
>  	help
>  	  This enable support for Freescale Vybrid VF610 processor.
>  
> -endif
> -
>  source "arch/arm/mach-imx/devices/Kconfig"
>  
>  endmenu
> -- 
> 1.8.3.2
> 
