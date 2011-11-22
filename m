From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2011 11:33:58 +0100
Subject: [PATCH] ARM: imx: drop 'ARCH_MX31' and 'ARCH_MX35'
In-Reply-To: <1321882445.32195.3.camel@x61.thuisdomein>
References: <1321882445.32195.3.camel@x61.thuisdomein>
Message-ID: <20111122103358.GA24770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:34:05PM +0100, Paul Bolle wrote:
> Commit 27ad4bf72a ("ARM: imx: move mx3 support to mach-imx") kept
> ARCH_MX31 and ARCH_MX35 'for compatibility'. Now that they aren't
> actually used anymore, they can be dropped entirely.

Added.

Thanks
 Sascha

> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> "git grep" tested only.
> 
>  arch/arm/mach-imx/Kconfig |   13 -------------
>  1 files changed, 0 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 5f7f9c2..c44aa97 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -10,11 +10,6 @@ config HAVE_IMX_MMDC
>  config HAVE_IMX_SRC
>  	bool
>  
> -#
> -# ARCH_MX31 and ARCH_MX35 are left for compatibility
> -# Some usages assume that having one of them implies not having (e.g.) ARCH_MX2.
> -# To easily distinguish good and reviewed from unreviewed usages new (and IMHO
> -# more sensible) names are used: SOC_IMX31 and SOC_IMX35
>  config ARCH_MX1
>  	bool
>  
> @@ -27,12 +22,6 @@ config ARCH_MX25
>  config MACH_MX27
>  	bool
>  
> -config ARCH_MX31
> -	bool
> -
> -config ARCH_MX35
> -	bool
> -
>  config SOC_IMX1
>  	bool
>  	select ARCH_MX1
> @@ -72,7 +61,6 @@ config SOC_IMX31
>  	select CPU_V6
>  	select IMX_HAVE_PLATFORM_MXC_RNGA
>  	select ARCH_MXC_AUDMUX_V2
> -	select ARCH_MX31
>  	select MXC_AVIC
>  	select SMP_ON_UP if SMP
>  
> @@ -82,7 +70,6 @@ config SOC_IMX35
>  	select ARCH_MXC_IOMUX_V3
>  	select ARCH_MXC_AUDMUX_V2
>  	select HAVE_EPIT
> -	select ARCH_MX35
>  	select MXC_AVIC
>  	select SMP_ON_UP if SMP
>  
> -- 
> 1.7.7.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
