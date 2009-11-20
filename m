From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 20 Nov 2009 13:03:58 +0100
Subject: [PATCH 2/8] s3c6410: Enable ADMA feature in 6410 sdhci controller.
Message-ID: <b2e8f9f70911200403r49e1fc4od58bd4a0d66a1e77@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables ADMA feature in 6410 SDHCI controller
driver.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 50997d2..0f8ff86 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -316,12 +316,7 @@ static int __devinit sdhci_s3c_probe(struct
platform_device *pdev)
 	host->irq = irq;

 	/* Setup quirks for the controller */
-
-	/* Currently with ADMA enabled we are getting some length
-	 * interrupts that are not being dealt with, do disable
-	 * ADMA until this is sorted out. */
-	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
-	host->quirks |= SDHCI_QUIRK_32BIT_ADMA_SIZE;
+	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;

 #ifndef CONFIG_MMC_SDHCI_S3C_DMA

-- 
1.6.5.3
