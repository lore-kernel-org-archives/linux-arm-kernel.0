From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sun, 13 Oct 2013 07:00:00 +0200
Subject: [PATCH] dma: coh901318: remove deprecated IRQF_DISABLED
Message-ID: <1381640400-7146-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 drivers/dma/coh901318.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 31011d2..3025b91 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -2694,7 +2694,7 @@ static int __init coh901318_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	err = devm_request_irq(&pdev->dev, irq, dma_irq_handler, IRQF_DISABLED,
+	err = devm_request_irq(&pdev->dev, irq, dma_irq_handler, 0,
 			       "coh901318", base);
 	if (err)
 		return err;
-- 
1.8.1.2
