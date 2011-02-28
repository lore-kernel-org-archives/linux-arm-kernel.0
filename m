From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Feb 2011 15:47:45 +0100
Subject: [patch 2/2] efika mx/sb: enable watchdog
In-Reply-To: <20110228132646.494426111@rtp-net.org>
References: <20110228132132.654689676@rtp-net.org>
	<20110228132646.494426111@rtp-net.org>
Message-ID: <20110228144745.GL22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

just one nitpick below ...

On Mon, Feb 28, 2011 at 02:21:34PM +0100, Arnaud Patard wrote:
> Register watchdog for efika mx and sb systems.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
> Index: linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/mx51_efika.c	2011-02-27 23:13:37.000000000 +0100
> +++ linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c	2011-02-27 23:20:38.000000000 +0100
> @@ -611,6 +611,7 @@
>  					ARRAY_SIZE(mx51efika_pads));
>  	imx51_add_imx_uart(0, &uart_pdata);
>  	mx51_efika_usb();
> +	imx51_add_imx2_wdt(0, NULL);
>  	imx51_add_sdhci_esdhc_imx(0, NULL);
>  
>  	/* FIXME: comes from original code. check this. */
> Index: linux-2.6-submit/arch/arm/mach-mx5/Kconfig
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/Kconfig	2011-02-27 23:13:42.000000000 +0100
> +++ linux-2.6-submit/arch/arm/mach-mx5/Kconfig	2011-02-27 23:20:38.000000000 +0100
> @@ -117,6 +117,7 @@
>  	bool
>  	select SOC_IMX51
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>  	select IMX_HAVE_PLATFORM_SPI_IMX
These IMX_HAVE_PLATFORM entries are sorted alphabetically and 2 sorts
before _, so IMX_HAVE_PLATFORM_IMX2_WDT should be the first entry here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
