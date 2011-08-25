From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 17:02:14 +0200
Subject: [patch 1/1] efika: Configure esdhc cd/wp on efika mx/sb
In-Reply-To: <20110825143806.625158261@rtp-net.org>
References: <20110825143806.625158261@rtp-net.org>
Message-ID: <20110825150214.GZ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Thu, Aug 25, 2011 at 04:37:57PM +0200, Arnaud Patard wrote:
> Update sdhc support on efika to make use of the latest mmc fixes.
> 
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> @@ -451,7 +465,8 @@ static void __init efikasb_board_init(vo
>  
>  	mx51_efikasb_board_id();
>  	mx51_efikasb_usb();
> -	imx51_add_sdhci_esdhc_imx(1, NULL);
> +	imx51_add_sdhci_esdhc_imx(0, &sd0_pdata);
> +	imx51_add_sdhci_esdhc_imx(1, &sd1_pdata);
>  	mx51_efikasb_display();
        ^^^^^^^^^^^^^^^^^^^

Looks good, but please rebase this onto a mainline kernel.

>  	platform_device_register(&mx51_efikasb_rfkill_device);
>  
> Index: linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/mach-mx5/mx51_efika.c	2011-06-20 20:36:15.000000000 +0200
> +++ linux-2.6-submit/arch/arm/mach-mx5/mx51_efika.c	2011-06-21 01:13:07.000000000 +0200
> @@ -704,7 +704,6 @@ void __init efika_board_common_init(void
>  	mx51_efika_usb();
>  	imx51_add_imx2_wdt(0, NULL);
>  	mx51_efika_i2c();
> -	imx51_add_sdhci_esdhc_imx(0, NULL);
>  
>  	/* FIXME: comes from original code. check this. */
>  	if (mx51_revision() < IMX_CHIP_REVISION_2_0)
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
