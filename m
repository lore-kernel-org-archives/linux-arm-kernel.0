From: b32955@freescale.com (Huang Shijie)
Date: Fri, 14 Jun 2013 16:06:23 +0800
Subject: [PATCH 2/4] mtd: gpmi: use DMA channel 0 for all the nand chips
In-Reply-To: <1371197185-27491-1-git-send-email-b32955@freescale.com>
References: <1371197185-27491-1-git-send-email-b32955@freescale.com>
Message-ID: <1371197185-27491-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only have one DMA channel : the channel 0.
Use DMA channel 0 to access all the nand chips.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 25ecfa1..036e5e4 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -226,9 +226,8 @@ int common_nfc_set_geometry(struct gpmi_nand_data *this)
 
 struct dma_chan *get_dma_chan(struct gpmi_nand_data *this)
 {
-	int chipnr = this->current_chip;
-
-	return this->dma_chans[chipnr];
+	/* We use the DMA channel 0 to access all the nand chips. */
+	return this->dma_chans[0];
 }
 
 /* Can we use the upper's buffer directly for DMA? */
-- 
1.7.1
