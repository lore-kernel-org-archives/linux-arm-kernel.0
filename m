From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 28 Sep 2011 14:18:08 +0200
Subject: [PATCH 6/6] arm/imx: merge i.MX3 and i.MX6
In-Reply-To: <1317201368-6403-7-git-send-email-shawn.guo@linaro.org>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
	<1317201368-6403-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110928121808.GY31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 05:16:08PM +0800, Shawn Guo wrote:
> 
>  
> -config ARCH_MX3
> -	bool "MX3-based"
> +config ARCH_IMX_V6_V7
> +	bool "i.MX3, i.MX6"
> +	select AUTO_ZRELADDR
> +	select ARM_PATCH_PHYS_VIRT

Russell pointed out that it's not a good idea to select this.

Sascha

>  	help
> -	  This enables support for systems based on the Freescale i.MX3 family
> +	  This enables support for systems based on the Freescale i.MX3 and i.MX6
> +	  family.
>  
>  config ARCH_MX5
>  	bool "i.MX50, i.MX51, i.MX53"
> @@ -29,13 +32,6 @@ config ARCH_MX5
>  	  This enables support for machines using Freescale's i.MX50 and i.MX51
>  	  processors.
>  
> -config ARCH_MX6
> -	bool "i.MX6"
> -	select AUTO_ZRELADDR
> -	select ARM_PATCH_PHYS_VIRT
> -	help
> -	  This enables support for systems based on the Freescale i.MX6 family
> -
>  endchoice
>  
>  source "arch/arm/mach-imx/Kconfig"
> -- 
> 1.7.4.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
