From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Nov 2013 09:51:46 +0100
Subject: [PATCH] ARM: imx: removed unused MACH_MXLADS Kconfig parameter
In-Reply-To: <1383542366-6270-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1383542366-6270-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <20131104085146.GT24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 06:19:26AM +0100, Michael Opdenacker wrote:
> This removes the MACH_MXLADS Kconfig parameter,
> which was no longer used anywhere in the source code
> and Makefiles.

Hehe, this one is a bit tricky. Indeed MACH_MXLADS isn't used directly
anywhere. Nevertheless having CONFIG_MACH_MXLADS defined makes
machine_is_mxlads() become true when the kernel is started with a
machine id of 1851.

machine_is_mxlads() is unused in the kernel, so this patch indeed
doesn't hurt. Anyway, the code is correct currently, so I suggest
keeping it until the mx[1l]ads is either removed or converted to
devicetree.

Sascha


> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> ---
>  arch/arm/mach-imx/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 29a8af6922a8..d84a772bbc68 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -158,14 +158,11 @@ config	SOC_IMX51
>  if ARCH_MULTI_V4T
>  
>  comment "MX1 platforms:"
> -config MACH_MXLADS
> -	bool
>  
>  config ARCH_MX1ADS
>  	bool "MX1ADS platform"
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
> -	select MACH_MXLADS
>  	select SOC_IMX1
>  	help
>  	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
> -- 
> 1.8.1.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
