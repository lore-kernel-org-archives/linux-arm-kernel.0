From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Tue, 25 May 2010 03:13:39 +0200
Subject: [PATCH 1/2] ARM: SAMSUNG: MMC: Fix build error when both DMA and
	PIO mode selected
Message-ID: <4BFB2443.1040701@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 drivers/mmc/host/s3cmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 2fdf768..4426a4b 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1600,7 +1600,7 @@ static int __devinit s3cmci_probe(struct platform_device
*pdev)
 	host->pio_active 	= XFER_NONE;

 #ifdef CONFIG_MMC_S3C_PIODMA
-	host->dodma		= host->pdata->dma;
+	host->dodma		= host->pdata->use_dma;
 #endif

 	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.1
