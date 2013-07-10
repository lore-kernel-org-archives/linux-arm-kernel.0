From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 10 Jul 2013 22:36:27 +0800
Subject: [PATCH v2 2/2] ARM: imx: Select MIGHT_HAVE_CACHE_L2X0
In-Reply-To: <1373461814-8844-2-git-send-email-fabio.estevam@freescale.com>
References: <1373461814-8844-1-git-send-email-fabio.estevam@freescale.com>
 <1373461814-8844-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130710143626.GC24654@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 10:10:14AM -0300, Fabio Estevam wrote:
> Select MIGHT_HAVE_CACHE_L2X0 for mx31/35/51/53/6q/6sl/vf610
> 
So maybe we can just do the following for config ARCH_MXC?

	select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7

Shawn

> By selecting MIGHT_HAVE_CACHE_L2X0, the user still has the possibility to 
> disable CACHE_L2X0 selection via menuconfig.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Use MIGHT_HAVE_CACHE_L2X0 instead of CACHE_L2X0, to allow users to still
> disable L2 cache via menuconfig if they want to
> - Also select L2 cache for vf610
> 
>  arch/arm/mach-imx/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index f546560..cc6961d 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -125,6 +125,7 @@ config SOC_IMX31
>  	select COMMON_CLK
>  	select CPU_V6
>  	select IMX_HAVE_PLATFORM_MXC_RNGA
> +	select MIGHT_HAVE_CACHE_L2X0
>  	select MXC_AVIC
>  	select SMP_ON_UP if SMP
>  
> @@ -134,6 +135,7 @@ config SOC_IMX35
>  	select COMMON_CLK
>  	select CPU_V6K
>  	select HAVE_EPIT
> +	select MIGHT_HAVE_CACHE_L2X0
>  	select MXC_AVIC
>  	select SMP_ON_UP if SMP
>  
> @@ -144,6 +146,7 @@ config SOC_IMX5
>  	select ARCH_MXC_IOMUX_V3
>  	select COMMON_CLK
>  	select CPU_V7
> +	select MIGHT_HAVE_CACHE_L2X0
>  	select MXC_TZIC
>  
>  config	SOC_IMX51
> @@ -799,6 +802,7 @@ config SOC_IMX6Q
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC
>  	select HAVE_SMP
> +	select MIGHT_HAVE_CACHE_L2X0
>  	select MFD_SYSCON
>  	select PINCTRL
>  	select PINCTRL_IMX6Q
> @@ -820,6 +824,7 @@ config SOC_IMX6SL
>  	select HAVE_IMX_GPC
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC
> +	select MIGHT_HAVE_CACHE_L2X0
>  	select MFD_SYSCON
>  	select PINCTRL
>  	select PINCTRL_IMX6SL
> @@ -835,6 +840,7 @@ config SOC_VF610
>  	select CPU_V7
>  	select ARM_GIC
>  	select CLKSRC_OF
> +	select MIGHT_HAVE_CACHE_L2X0
>  	select PINCTRL
>  	select PINCTRL_VF610
>  	select VF_PIT_TIMER
> -- 
> 1.8.1.2
> 
> 
