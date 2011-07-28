From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Jul 2011 16:42:30 +0200
Subject: [patch 1/3] imx51: add pata device
In-Reply-To: <20110726145515.490011169@rtp-net.org>
References: <20110726145424.575429100@rtp-net.org>
	<20110726145515.490011169@rtp-net.org>
Message-ID: <20110728144230.GV16561@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 04:54:25PM +0200, Arnaud Patard wrote:
> Declare the pata device found on mx51
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/mach-mx5/devices-imx51.h
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/devices-imx51.h	2011-07-22 23:29:13.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/devices-imx51.h	2011-07-24 20:35:30.000000000 +0200
> @@ -52,3 +52,7 @@ extern const struct imx_mxc_pwm_data imx
>  extern const struct imx_imx_keypad_data imx51_imx_keypad_data;
>  #define imx51_add_imx_keypad(pdata)	\
>  	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
> +
> +extern const struct imx_pata_imx_data imx51_pata_imx_data;
> +#define imx51_add_pata_imx() \
> +	imx_add_pata_imx(&imx51_pata_imx_data)
> Index: linux-2.6-submit/arch/arm/plat-mxc/devices/Kconfig
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/plat-mxc/devices/Kconfig	2011-07-22 23:29:13.000000000 +0200
> +++ linux-2.6-submit/arch/arm/plat-mxc/devices/Kconfig	2011-07-24 20:35:30.000000000 +0200
> @@ -31,6 +31,9 @@ config IMX_HAVE_PLATFORM_IMX_I2C
>  config IMX_HAVE_PLATFORM_IMX_KEYPAD
>  	bool
>  
> +config IMX_HAVE_PLATFORM_PATA_IMX
> +	bool
> +
this breaks the alphabetic ordering in this file.
arch/arm/plat-mxc/devices/Makefile is affected, too.

Other than that I don't see any issues any more. Sascha, maybe you can
fix that up while committing (assuming nobody has more objections)?
Arnaud told me on irc that he is occupied and cannot follow up soon.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
