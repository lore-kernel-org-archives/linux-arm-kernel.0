From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 16 Jul 2011 23:24:29 +0200
Subject: [patch 3/3] imx: efika: Enable pata.
In-Reply-To: <20110716210155.452675636@rtp-net.org>
References: <20110716204411.832712955@rtp-net.org>
	<20110716210155.452675636@rtp-net.org>
Message-ID: <20110716212429.GB1233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2011 at 10:44:14PM +0200, Arnaud Patard wrote:
> Enable pata support on efika mx/sb platforms.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/mach-mx5/Kconfig
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/Kconfig	2011-07-16 16:19:53.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/Kconfig	2011-07-16 16:22:34.000000000 +0200
> @@ -147,6 +147,7 @@ config MX51_EFIKA_COMMON
>  	bool
>  	select SOC_IMX51
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
> +	select IMX_HAVE_PLATFORM_IMX_PATA
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>  	select IMX_HAVE_PLATFORM_SPI_IMX
> Index: linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/mx51_efika.c	2011-07-16 16:19:53.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c	2011-07-16 16:21:22.000000000 +0200
> @@ -629,6 +629,8 @@ void __init efika_board_common_init(void
>  		ARRAY_SIZE(mx51_efika_spi_board_info));
>  	imx51_add_ecspi(0, &mx51_efika_spi_pdata);
>  
> +	imx_add_mxc_pata(&im51_mxc_pata_data);
> +
I'd prefer to have imx51_add_mxc_pata() which expands to
imx_add_mxc_pata(&imx51_mxc_pata_data)

Why didn't you add that?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
