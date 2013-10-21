From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 21 Oct 2013 22:27:04 +0800
Subject: [PATCH 4/7] mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6
In-Reply-To: <1382365627-26816-1-git-send-email-b29396@freescale.com>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
Message-ID: <1382365627-26816-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 supports 1.8v/3.3v eMMC DDR mode, so add this flag.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2be77e0..5fe484f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1025,6 +1025,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (esdhc_is_usdhc(imx_data)) {
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
-- 
1.7.2.rc3
