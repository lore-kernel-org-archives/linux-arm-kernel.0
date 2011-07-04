From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 04 Jul 2011 13:44:35 -0400
Subject: [PATCH 1/2] SPI: S5PC100: Enable the SPI driver for S5PC100
Message-ID: <1309801476-29678-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: padmavathi venna <padma.v@samsung.com>

The SPI module on S5PC100 is similar to the earlier Samsung SoCs like
S3C64XX. Enable the existing SPI driver for use on S5PC100.

Signed-off-by: padmavathi venna <padma.v@samsung.com>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index de35c3a..91d607b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -340,7 +340,7 @@ config SPI_S3C24XX_GPIO
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (ARCH_S3C64XX || ARCH_S5P64X0)
+	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_S5PC100)
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
-- 
1.7.0.4
