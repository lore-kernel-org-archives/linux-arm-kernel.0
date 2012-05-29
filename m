From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:36:58 +0100
Subject: [RFC 05/34] dmaengine: PL08x: fix missed dma_transfer_direction fixup
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIrK-0006z2-CV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

db8196df4 (dmaengine: move drivers to dma_transfer_direction) missed
fixing up the "DMA_NONE" case.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 8931682..a5bb7f8 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1283,7 +1283,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	}
 	list_add_tail(&dsg->node, &txd->dsg_list);
 
-	txd->direction = DMA_NONE;
+	txd->direction = DMA_MEM_TO_MEM;
 	dsg->src_addr = src;
 	dsg->dst_addr = dest;
 	dsg->len = len;
-- 
1.7.4.4
