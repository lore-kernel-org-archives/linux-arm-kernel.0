From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 22 Jun 2012 10:01:34 +0100
Subject: [PATCH 2/3] dmaengine: omap: add support for setting fi
In-Reply-To: <20120622085911.GA19026@n2100.arm.linux.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Message-ID: <E1ShzkE-0004h8-3u@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 62b6a2b..e1a326d 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -50,6 +50,7 @@ struct omap_desc {
 	enum dma_transfer_direction dir;
 	dma_addr_t dev_addr;
 
+	int16_t fi;		/* for OMAP_DMA_SYNC_PACKET */
 	uint8_t es;		/* element size */
 	uint8_t sync_mode;	/* OMAP_DMA_SYNC_xxx */
 	uint8_t sync_type;	/* OMAP_DMA_xxx_SYNC* */
@@ -120,10 +121,10 @@ static void omap_dma_start_desc(struct omap_chan *c)
 
 	if (d->dir == DMA_DEV_TO_MEM)
 		omap_set_dma_src_params(c->dma_ch, d->periph_port,
-			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
+			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, d->fi);
 	else
 		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
-			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
+			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, d->fi);
 
 	omap_dma_start_sg(c, d, 0);
 }
-- 
1.7.4.4
