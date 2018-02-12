From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 12 Feb 2018 21:02:44 +0100
Subject: [PATCH] mmc: sdhci-iproc: Disable preset values for BCM2835
Message-ID: <1518465764-30051-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the BCM2835 datasheet there are no preset value registers.
This wasn't an issue before, because we didn't propagate 1.8V support.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 61666d2..0ef741b 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -214,6 +214,7 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_MISSING_CAPS |
 		  SDHCI_QUIRK_NO_HISPD_BIT,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_iproc_32only_ops,
 };
 
-- 
2.7.4
