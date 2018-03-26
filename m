From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 26 Mar 2018 18:04:18 +0800
Subject: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
Message-ID: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 86bf456..9fdc2e5 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -856,4 +856,3 @@ module_platform_driver(mtk_spi_driver);
 MODULE_DESCRIPTION("MTK SPI Controller driver");
 MODULE_AUTHOR("Leilk Liu <leilk.liu@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mtk-spi");
-- 
2.7.4
