From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 13 Apr 2011 20:25:04 +0800
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110413122503.GB1897@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2011 at 09:49:01PM +0200, Uwe Kleine-K?nig wrote:
[...]
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index ce6ed5e..aa4234b 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -4,6 +4,12 @@ source "arch/arm/plat-mxc/devices/Kconfig"
>  
>  menu "Freescale MXC Implementations"
>  
> +config ARCH_MX50_SUPPORTED
> +	bool
> +
> +config ARCH_MX53_SUPPORTED
> +	bool
> +
>  choice
>  	prompt "Set of supported SoCs:"
>  	default ARCH_MX3
> @@ -36,8 +42,17 @@ config ARCH_MX3
>  	  This enables support for machines using Freescale's i.MX31 and i.MX35
>  	  processors.
>  
> -config ARCH_MX5
> -	bool "MX5-based"
> +config ARCH_MX503
> +	bool "i.MX50 + i.MX53"
> +	select ARCH_MX50_SUPPORTED
> +	select ARCH_MX53_SUPPORTED
> +	help
> +	  This enables support for machines using Freescale's i.MX50 and i.MX51
s/MX51/MX53/

-- 
Regards,
Shawn
