From: luis@debethencourt.com (Luis de Bethencourt)
Date: Wed, 16 Sep 2015 22:59:31 +0200
Subject: [PATCH 5/6] dmaengine: sun6i: Fix module autoload for OF platform
 driver
Message-ID: <20150916205931.GA5882@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/dma/sun6i-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 73e0be6..2db12e4 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -908,6 +908,7 @@ static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sun6i_dma_match);
 
 static int sun6i_dma_probe(struct platform_device *pdev)
 {
-- 
2.4.6
