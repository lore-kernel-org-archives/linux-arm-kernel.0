From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 19 Aug 2016 20:00:33 +0800
Subject: [PATCH] usb: chipidea: usb2: delete the redundant setting default DMA
 mask code
Message-ID: <20160819120033.556-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar as commit 2b2fe36def08 ("usb: chipidea: imx: delete the
redundant setting default DMA mask code"), the ci_hdrc_usb2 platform
device is also created by device tree, the default DMA mask should be
already set by of_dma_configure when the device are created. So delete
the redundant code at driver.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 4456d2c..d162cc0 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -74,10 +74,6 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto clk_err;
-
 	ci_pdata->name = dev_name(dev);
 
 	priv->ci_pdev = ci_hdrc_add_device(dev, pdev->resource,
-- 
2.9.3
