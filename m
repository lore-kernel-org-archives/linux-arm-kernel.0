From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 16:35:38 +0800
Subject: [PATCH 1/3] dmaengine: sirf: fix a typo in dma_prep_interleaved
Message-ID: <1348734938-20014-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

either DEV_TO_MEM or MEM_TO_DEV is supported, so change
OR to AND.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/dma/sirf-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 434ad31..35a329d 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -428,7 +428,7 @@ static struct dma_async_tx_descriptor *sirfsoc_dma_prep_interleaved(
 	unsigned long iflags;
 	int ret;
 
-	if ((xt->dir != DMA_MEM_TO_DEV) || (xt->dir != DMA_DEV_TO_MEM)) {
+	if ((xt->dir != DMA_MEM_TO_DEV) && (xt->dir != DMA_DEV_TO_MEM)) {
 		ret = -EINVAL;
 		goto err_dir;
 	}
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
