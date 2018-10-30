From: peng.ma@nxp.com (Peng Ma)
Date: Tue, 30 Oct 2018 10:35:58 +0800
Subject: [v11 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
Message-ID: <20181030023604.34027-1-peng.ma@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wen He <wen.he_1@nxp.com>

This patch implement a standard macro call functions is
used to NXP dma drivers.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
change in v11:
	- no

 drivers/dma/fsldma.c |   16 ++++++++--------
 drivers/dma/fsldma.h |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1117b51..39871e0 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -53,42 +53,42 @@
 
 static void set_sr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->sr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->sr, val, 32);
 }
 
 static u32 get_sr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->sr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->sr, 32);
 }
 
 static void set_mr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->mr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->mr, val, 32);
 }
 
 static u32 get_mr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->mr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->mr, 32);
 }
 
 static void set_cdar(struct fsldma_chan *chan, dma_addr_t addr)
 {
-	DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
+	FSL_DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
 }
 
 static dma_addr_t get_cdar(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
+	return FSL_DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
 }
 
 static void set_bcr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->bcr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->bcr, val, 32);
 }
 
 static u32 get_bcr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->bcr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->bcr, 32);
 }
 
 /*
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 4787d48..982845b 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -223,10 +223,10 @@ static void out_le64(u64 __iomem *addr, u64 val)
 }
 #endif
 
-#define DMA_IN(fsl_chan, addr, width)					\
+#define FSL_DMA_IN(fsl_chan, addr, width)				\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
 			in_be##width(addr) : in_le##width(addr))
-#define DMA_OUT(fsl_chan, addr, val, width)				\
+#define FSL_DMA_OUT(fsl_chan, addr, val, width)			\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
 			out_be##width(addr, val) : out_le##width(addr, val))
 
-- 
1.7.1
