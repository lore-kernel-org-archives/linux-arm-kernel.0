From: buserror@gmail.com (Michel Pollet)
Date: Tue,  2 Feb 2010 12:40:20 +0000
Subject: [PATCH] ARM: S3C: Fix a compilation error in MCI
Message-ID: <1265114420-22925-1-git-send-email-buserror@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refers to a non-existing (renamed?) field in the s3c24xx_mci_pdata
structure.

Signed-off-by: Michel Pollet <buserror@gmail.com>
---
 drivers/mmc/host/s3cmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index d96e1ab..cd67efb 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1598,7 +1598,7 @@ static int __devinit s3cmci_probe(struct platform_device *pdev)
 	host->pio_active 	= XFER_NONE;
 
 #ifdef CONFIG_MMC_S3C_PIODMA
-	host->dodma		= host->pdata->dma;
+	host->dodma		= host->pdata->use_dma;
 #endif
 
 	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.6.6
