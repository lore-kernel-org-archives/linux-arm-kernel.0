From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Nov 2009 08:37:50 +0100
Subject: [patch] Add USB Gadget support for mx35pdk
In-Reply-To: <20091126151019.837865490@yahoo.com>
References: <20091126151019.837865490@yahoo.com>
Message-ID: <20091127073750.GF27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 04:09:11PM +0100, Harro Haan wrote:
> Add USB Gadget support for mx35pdk
> 
> The patch is baselined on:
> git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master
> 
> Signed-off-by: Harro Haan <hrhaan@yahoo.com>
> ---
>  arch/arm/mach-mx3/clock-imx35.c |    3 +++
>  arch/arm/mach-mx3/mx35pdk.c     |   12 ++++++++++++
>  drivers/usb/gadget/Kconfig      |    2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.31/drivers/usb/gadget/Kconfig
> ===================================================================
> --- linux-2.6.31.orig/drivers/usb/gadget/Kconfig	2009-11-25 17:57:01.000000000 +0100
> +++ linux-2.6.31/drivers/usb/gadget/Kconfig	2009-11-25 18:13:28.000000000 +0100
> @@ -156,7 +156,7 @@ config USB_ATMEL_USBA
>  
>  config USB_GADGET_FSL_USB2
>  	boolean "Freescale Highspeed USB DR Peripheral Controller"
> -	depends on FSL_SOC || ARCH_MXC
> +	depends on FSL_SOC || ARCH_MXC || ARCH_MX35
>  	select USB_GADGET_DUALSPEED
>  	help
>  	   Some of Freescale PowerPC processors have a High Speed

This shouldn't be needed. ARCH_MX35 won't be set without ARCH_MXC.

Sascha



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
