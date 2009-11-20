From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 20 Nov 2009 13:04:01 +0100
Subject: [PATCH 3/8] S3C64xx: remove SDHCI_QUIRK_NO_MULTIBLOCK
Message-ID: <b2e8f9f70911200404pca38ab6ycdca740ce81a6847@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes SDIO as that requires multiblock transfers

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0f8ff86..4623876 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -324,9 +324,6 @@ static int __devinit sdhci_s3c_probe(struct
platform_device *pdev)
 	 * support as well. */
 	host->quirks |= SDHCI_QUIRK_BROKEN_DMA;

-	/* PIO currently has problems with multi-block IO */
-	host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
-
 #endif /* CONFIG_MMC_SDHCI_S3C_DMA */

 	/* It seems we do not get an DATA transfer complete on non-busy
-- 
1.6.5.3
