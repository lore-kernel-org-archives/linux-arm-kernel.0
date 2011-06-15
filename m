From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 15 Jun 2011 12:44:04 +0200
Subject: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
	write_protect support for mx5
In-Reply-To: <20110615103344.GA3579@S2100-06.ap.freescale.net>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
	<1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
	<20110614095129.GD5043@pengutronix.de>
	<20110614130610.GH30295@S2100-06.ap.freescale.net>
	<20110615103344.GA3579@S2100-06.ap.freescale.net>
Message-ID: <20110615104404.GA3097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sorry.  I had some reason for moving esdhc_pltfm_get_ro around.  We
> can not keep the existing approach (what I said above).  For mx51
> babbage example, esdhc1 uses internal WP while esdhc2 uses gpio WP.
> If we have esdhc_pltfm_get_ro handle gpio only and assign it to
> sdhci_esdhc_ops.get_ro in .probe only when wp_type is ESDHC_WP_GPIO,
> that works for esdhc2 but breaks esdhc1 WP function.  So no, I will
> not change my code except adding NONE case handling there.

Ok, fine with me. Thanks for checking!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110615/d5cff7fc/attachment.sig>
