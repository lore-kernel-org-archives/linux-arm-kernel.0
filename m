From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Apr 2017 13:09:45 +0200
Subject: [PATCH] mtd: spi-nor: stm32: remove broken MODULE_ALIAS
Message-ID: <20170427111001.2587551-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MODULE_ALIAS statement refers to a macro that has never been defined
in this driver, causing a build error:

drivers/mtd/spi-nor/stm32-quadspi.c:694:150: error: expected ',' or ';' before 'DRIVER_NAME'

Unless there is a specific alias we need other then the driver name,
we don't need an alias here and can simply remove the line to fix the
build.

Fixes: dc5e400611c5 ("mtd: spi-nor: add driver for STM32 quad spi flash controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/spi-nor/stm32-quadspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
index 90d9152ddf98..1056e7408d2a 100644
--- a/drivers/mtd/spi-nor/stm32-quadspi.c
+++ b/drivers/mtd/spi-nor/stm32-quadspi.c
@@ -691,7 +691,6 @@ static struct platform_driver stm32_qspi_driver = {
 };
 module_platform_driver(stm32_qspi_driver);
 
-MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Ludovic Barre <ludovic.barre@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics STM32 quad spi driver");
 MODULE_LICENSE("GPL v2");
-- 
2.9.0
