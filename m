From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 27 Apr 2014 18:25:31 +0800
Subject: [RESEND][PATCH] mmc: wmt-sdmmc: Remove deprecated IRQF_DISABLED
Message-ID: <1398594331.6291.4.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's a NOOP since 2.6.35 and it will be removed one day.
This is not trivial because current code uses hard coded 32 instead of
IRQF_DISABLED in the request_irq call.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on:
http://www.spinics.net/lists/linux-mmc/msg22644.html

 drivers/mmc/host/wmt-sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 5501c9f..8a48a50 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -829,7 +829,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 		goto fail3;
 	}
 
-	ret = request_irq(dma_irq, wmt_mci_dma_isr, 32, "sdmmc", priv);
+	ret = request_irq(dma_irq, wmt_mci_dma_isr, 0, "sdmmc", priv);
 	if (ret) {
 		dev_err(&pdev->dev, "Register DMA IRQ fail\n");
 		goto fail4;
-- 
1.8.1.2
