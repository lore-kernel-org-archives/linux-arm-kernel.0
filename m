From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 21 Apr 2016 09:24:01 +0000
Subject: [PATCH] dmaengine: bcm2835: fix typo in legacy-mode warning message
Message-ID: <1461230641-20317-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Fix typo in warning message that there is no "interrupt-names"
property defined in the device-tree and legacy-mode is used.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9740151..d724393 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -974,7 +974,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 		/* legacy device tree case handling */
 		dev_warn_once(&pdev->dev,
-			      "missing interrupts-names property in device tree - legacy interpretation is used");
+			      "missing interrupt-names property in device tree - legacy interpretation is used");
 		/*
 		 * in case of channel >= 11
 		 * use the 11th interrupt and that is shared
-- 
2.1.4
