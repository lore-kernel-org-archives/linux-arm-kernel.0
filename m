From: stigge@antcom.de (Roland Stigge)
Date: Thu, 16 Aug 2012 10:56:36 +0200
Subject: [PATCH] dma: amba-pl08x: Export pl08x_filter_id
Message-ID: <1345107396-27079-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following when compiling a driver module that uses
amba-pl08x:

ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_slc.ko] undefined!
ERROR: "pl08x_filter_id" [drivers/mtd/nand/lpc32xx_mlc.ko] undefined!

(drivers/mtd/nand/lpc32xx_* are still in l2-mtd.git)

Done as in:

drivers/dma/coh901318.c
drivers/dma/sirf-dma.c

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6fbeebb..8c2e9b6 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1608,6 +1608,7 @@ bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
 
 	return false;
 }
+EXPORT_SYMBOL(pl08x_filter_id);
 
 /*
  * Just check that the device is there and active
