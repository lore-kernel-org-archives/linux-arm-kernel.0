From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 May 2011 11:48:42 +0200
Subject: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110519094841.GB2219@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +config MMC_SDHCI_ESDHC
> +	bool
> +	depends on MMC_SDHCI
> +	select MMC_SDHCI_PLTFM
> +	help
> +	  This selects SDHCI driver for Freescale eSDHC controller.

bool is not a good choice here, because if ESDHC_IMX is selected as a
module (-m), it will get converted here to built-in (-y). Same goes for
MMC_SDHCI_PLTFM. If I change both into tristate and then compile, I get
a build error:

ERROR: "sdhci_pltfm_suspend" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_get_of_property" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_pltfm_init" [drivers/mmc/host/sdhci-esdhc.ko] undefined!
ERROR: "sdhci_pltfm_free" [drivers/mmc/host/sdhci-esdhc.ko] undefined!

So, the module-support seems to be missing for the library.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110519/988d1669/attachment-0001.sig>
