From: luis@debethencourt.com (Luis de Bethencourt)
Date: Wed, 16 Sep 2015 22:58:53 +0200
Subject: [PATCH 4/6] dmaengine: sirf: Fix module autoload for OF platform
 driver
Message-ID: <20150916205853.GA5871@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/dma/sirf-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 7d5598d..22ea241 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -1149,6 +1149,7 @@ static const struct of_device_id sirfsoc_dma_match[] = {
 	{ .compatible = "sirf,atlas7-dmac-v2", .data = &sirfsoc_dmadata_a7v2,},
 	{},
 };
+MODULE_DEVICE_TABLE(of, sirfsoc_dma_match);
 
 static struct platform_driver sirfsoc_dma_driver = {
 	.probe		= sirfsoc_dma_probe,
-- 
2.4.6
