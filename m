From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Feb 2010 01:06:14 +0100
Subject: [PATCH 7/7] DMAENGINE: add COH 901 318 AMBA/PrimeCell extension
Message-ID: <1266537974-13638-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a dummy extenstion for handling PrimeCell configuration
on the COH 901 318. We might start to use the data passed in
soonish, since hard-coding the source/target addresses for DMA
into the DMA platform config is probably a bad idea.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/coh901318.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 372f314..7bc61f8 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <mach/coh901318.h>
+#include <linux/amba/dma.h>
 
 #include "coh901318_lli.h"
 
@@ -1122,6 +1123,13 @@ coh901318_terminate_all(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
 }
+
+void dma_set_ambaconfig(struct dma_chan *chan,
+			struct amba_dma_channel_config *config)
+{
+	/* Dummy implementation - our channels currently knows all */
+}
+
 void coh901318_base_init(struct dma_device *dma, const int *pick_chans,
 			 struct coh901318_base *base)
 {
-- 
1.6.6
