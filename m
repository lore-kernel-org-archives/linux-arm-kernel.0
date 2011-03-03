From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Mar 2011 13:54:04 +0100
Subject: [patch v2 2/2] efika mx/sb: enable watchdog
In-Reply-To: <20110302185002.798370465@rtp-net.org>
References: <20110302184512.512010086@rtp-net.org>
	<20110302185002.798370465@rtp-net.org>
Message-ID: <20110303125404.GM29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

On Wed, Mar 02, 2011 at 07:45:14PM +0100, Arnaud Patard wrote:
> Register watchdog for efika mx and sb systems.

I promised myself to keep a better eye on patches I can't take because
they have dependencies to other subsystems. This patch is one of those
as it depends on the wdi_reboot field in the platform data.
Can you please resend this once the other patches have hit mainline?

Sascha

> 
> v2:
> - reorder Kconfig entry
> - set wdi_reboot in mc13xxx platform data
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
> Index: linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/mx51_efika.c	2011-03-01 22:24:31.000000000 +0100
> +++ linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c	2011-03-01 22:36:35.000000000 +0100
> @@ -574,6 +574,7 @@
>  	.flags = MC13XXX_USE_RTC | MC13XXX_USE_REGULATOR,
>  	.num_regulators = ARRAY_SIZE(mx51_efika_regulators),
>  	.regulators = mx51_efika_regulators,
> +	.wdi_reboot = 1,
>  };
>  
>  static struct spi_board_info mx51_efika_spi_board_info[] __initdata = {
> @@ -611,6 +612,7 @@
>  					ARRAY_SIZE(mx51efika_pads));
>  	imx51_add_imx_uart(0, &uart_pdata);
>  	mx51_efika_usb();
> +	imx51_add_imx2_wdt(0, NULL);
>  	imx51_add_sdhci_esdhc_imx(0, NULL);
>  
>  	/* FIXME: comes from original code. check this. */
> Index: linux-2.6-submit/arch/arm/mach-mx5/Kconfig
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/Kconfig	2011-03-01 22:24:31.000000000 +0100
> +++ linux-2.6-submit/arch/arm/mach-mx5/Kconfig	2011-03-01 22:35:47.000000000 +0100
> @@ -116,6 +116,7 @@
>  config MX51_EFIKA_COMMON
>  	bool
>  	select SOC_IMX51
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>  	select IMX_HAVE_PLATFORM_SPI_IMX
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
