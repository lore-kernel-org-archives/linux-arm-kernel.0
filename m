From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jan 2010 13:23:43 -0800
Subject: [PATCH 4/4] OMAP: dma_chan[lch_head].flag & OMAP_DMA_ACTIVE tested
	twice in omap_dma_unlink_lch()
In-Reply-To: <20100120212248.25335.55761.stgit@baageli.muru.com>
References: <20100120212248.25335.55761.stgit@baageli.muru.com>
Message-ID: <20100120212343.25335.73402.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roel Kluin <roel.kluin@gmail.com>

The same flag and bits were tested twice.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 09d82b3..728c642 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1183,7 +1183,7 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 	}
 
 	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
-	    (dma_chan[lch_head].flags & OMAP_DMA_ACTIVE)) {
+	    (dma_chan[lch_queue].flags & OMAP_DMA_ACTIVE)) {
 		printk(KERN_ERR "omap_dma: You need to stop the DMA channels "
 		       "before unlinking\n");
 		dump_stack();
