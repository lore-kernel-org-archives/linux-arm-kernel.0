From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 16 Apr 2016 01:29:35 +0800
Subject: [PATCH 11/23] mmc: sdhci-esdhci-imx: remove
 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1460741387-23815-12-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has already implemented the private .set_timeout()
callback for common SDHCI code to do correct timeout value setting,
it does not need call sdhci_calc_timeout(), so this quirk actually
is not working. Remove it now.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2d300d8..03980db 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1147,8 +1147,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(imx_data->pins_default))
 		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
 
-	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
-- 
1.9.1
