From: olof@lixom.net (Olof Johansson)
Date: Sun,  7 Jul 2013 11:05:55 -0700
Subject: [PATCH] dma: iop: fix new warnings
Message-ID: <1373220355-26712-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent "drivers/dma: remove unused support for MEMSET operations"
change has fallout from lack of build testing by the author. This fixes:

drivers/dma/iop-adma.c:1020:13: warning: unused variable 'dma_addr' [-Wunused-variable]
drivers/dma/iop-adma.c:1519:2: warning: format '%s' expects a matching 'char *' argument [-Wformat=]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/dma/iop-adma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index c9cc08c..cc727ec 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1017,7 +1017,7 @@ iop_adma_xor_val_self_test(struct iop_adma_device *device)
 	struct page *xor_srcs[IOP_ADMA_NUM_SRC_TEST];
 	struct page *zero_sum_srcs[IOP_ADMA_NUM_SRC_TEST + 1];
 	dma_addr_t dma_srcs[IOP_ADMA_NUM_SRC_TEST + 1];
-	dma_addr_t dma_addr, dest_dma;
+	dma_addr_t dest_dma;
 	struct dma_async_tx_descriptor *tx;
 	struct dma_chan *dma_chan;
 	dma_cookie_t cookie;
@@ -1516,7 +1516,7 @@ static int iop_adma_probe(struct platform_device *pdev)
 			goto err_free_iop_chan;
 	}
 
-	dev_info(&pdev->dev, "Intel(R) IOP: ( %s%s%s%s%s%s%s)\n",
+	dev_info(&pdev->dev, "Intel(R) IOP: ( %s%s%s%s%s%s)\n",
 		 dma_has_cap(DMA_PQ, dma_dev->cap_mask) ? "pq " : "",
 		 dma_has_cap(DMA_PQ_VAL, dma_dev->cap_mask) ? "pq_val " : "",
 		 dma_has_cap(DMA_XOR, dma_dev->cap_mask) ? "xor " : "",
-- 
1.7.10.4
