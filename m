From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 13 Feb 2018 21:54:03 +0100
Subject: [PATCH] dmaengine: at_xdmac: Delete an error message for a failed
 memory allocation in at_xdmac_probe()
Message-ID: <980fa869-f75b-3436-a329-09613e2ab915@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 21:48:26 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/at_xdmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c00e3923d7d8..818ab96f9601 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1950,10 +1950,8 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	size = sizeof(*atxdmac);
 	size += nr_channels * sizeof(struct at_xdmac_chan);
 	atxdmac = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
-	if (!atxdmac) {
-		dev_err(&pdev->dev, "can't allocate at_xdmac structure\n");
+	if (!atxdmac)
 		return -ENOMEM;
-	}
 
 	atxdmac->regs = base;
 	atxdmac->irq = irq;
-- 
2.16.1
