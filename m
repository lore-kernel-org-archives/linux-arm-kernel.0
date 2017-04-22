From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Apr 2017 23:24:23 +0200
Subject: [PATCH 1/2] dmaengine: s3c24xx: Use devm_kcalloc() in
 s3c24xx_dma_probe()
In-Reply-To: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
References: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
Message-ID: <9c10b823-f49b-8c73-2bf8-0fd2b0ba0231@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 22 Apr 2017 23:00:23 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "devm_kcalloc".

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/s3c24xx-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index f04c4702d98b..967229829683 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1216,10 +1216,10 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(s3cdma->base))
 		return PTR_ERR(s3cdma->base);
 
-	s3cdma->phy_chans = devm_kzalloc(&pdev->dev,
-					      sizeof(struct s3c24xx_dma_phy) *
-							pdata->num_phy_channels,
-					      GFP_KERNEL);
+	s3cdma->phy_chans = devm_kcalloc(&pdev->dev,
+					 pdata->num_phy_channels,
+					 sizeof(*s3cdma->phy_chans),
+					 GFP_KERNEL);
 	if (!s3cdma->phy_chans)
 		return -ENOMEM;
 
-- 
2.12.2
