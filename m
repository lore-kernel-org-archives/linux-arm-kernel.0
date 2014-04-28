From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 28 Apr 2014 08:58:31 +0800
Subject: [PATCH] mmc: wmt-sdmmc: Use GFP_KERNEL instead of hard-coded value
Message-ID: <1398646711.10750.0.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 34231d5..3605c37 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -852,7 +852,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	priv->dma_desc_buffer = dma_alloc_coherent(&pdev->dev,
 						   mmc->max_blk_count * 16,
 						   &priv->dma_desc_device_addr,
-						   208);
+						   GFP_KERNEL);
 	if (!priv->dma_desc_buffer) {
 		dev_err(&pdev->dev, "DMA alloc fail\n");
 		ret = -EPERM;
-- 
1.8.1.2
