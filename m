From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 16 Jul 2011 23:22:28 +0200
Subject: [patch 1/3] imx51: add pata device
In-Reply-To: <20110716210149.854331030@rtp-net.org>
References: <20110716204411.832712955@rtp-net.org>
	<20110716210149.854331030@rtp-net.org>
Message-ID: <20110716212228.GA1233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2011 at 10:44:12PM +0200, Arnaud Patard wrote:
> Declare the pata device found on mx51
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---
> Index: linux-2.6-submit/arch/arm/mach-mx5/devices-imx51.h
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/devices-imx51.h	2011-07-16 16:16:40.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/devices-imx51.h	2011-07-16 16:20:33.000000000 +0200
> @@ -52,3 +52,5 @@ extern const struct imx_mxc_pwm_data imx
>  extern const struct imx_imx_keypad_data imx51_imx_keypad_data;
>  #define imx51_add_imx_keypad(pdata)	\
>  	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
> +
> +extern const struct imx_mxc_pata_data im51_mxc_pata_data;
imx51 please

> Index: linux-2.6-submit/arch/arm/plat-mxc/devices/Kconfig
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/plat-mxc/devices/Kconfig	2011-07-16 16:16:40.000000000 +0200
> +++ linux-2.6-submit/arch/arm/plat-mxc/devices/Kconfig	2011-07-16 16:20:08.000000000 +0200
> @@ -31,6 +31,9 @@ config IMX_HAVE_PLATFORM_IMX_I2C
>  config IMX_HAVE_PLATFORM_IMX_KEYPAD
>  	bool
>  
> +config IMX_HAVE_PLATFORM_IMX_PATA
> +	bool
> +
>  config IMX_HAVE_PLATFORM_IMX_SSI
>  	bool
>  
> Index: linux-2.6-submit/arch/arm/plat-mxc/devices/Makefile
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/plat-mxc/devices/Makefile	2011-07-16 16:16:40.000000000 +0200
> +++ linux-2.6-submit/arch/arm/plat-mxc/devices/Makefile	2011-07-16 16:20:08.000000000 +0200
> @@ -10,6 +10,7 @@ obj-y += platform-imx-dma.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_KEYPAD) += platform-imx-keypad.o
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_PATA) += platform-imx-pata.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
> Index: linux-2.6-submit/arch/arm/plat-mxc/devices/platform-imx-pata.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6-submit/arch/arm/plat-mxc/devices/platform-imx-pata.c	2011-07-16 16:20:08.000000000 +0200
> @@ -0,0 +1,38 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +
> +#define imx_mxc_pata_data_entry_single(soc)				\
> +	{								\
> +		.iobase = soc ## _ATA_BASE_ADDR,			\
> +		.irq = soc ## _MXC_INT_ATA,				\
> +	}
> +
> +#ifdef CONFIG_SOC_IMX51
> +const struct imx_mxc_pata_data im51_mxc_pata_data __initconst =
> +	imx_mxc_pata_data_entry_single(MX51);
obviously here, too

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
