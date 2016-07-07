From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu,  7 Jul 2016 12:17:49 -0500
Subject: [RFC] [PATCH v3 2/4] spi: spi-omap2-mcspi: Select SPI_SPLIT
In-Reply-To: <1467911871-4508-1-git-send-email-fcooper@ti.com>
References: <1467911871-4508-1-git-send-email-fcooper@ti.com>
Message-ID: <1467911871-4508-3-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function spi_split will be used by spi-omap2-mcspi to handle a SoC
workaround in the SPI driver. Therefore, select SPI_SPLIT so this function
is available to the driver.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b931ec..d6fb8d4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -411,6 +411,7 @@ config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
 	depends on HAS_DMA
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	select SG_SPLIT
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
 	  (McSPI) modules.
-- 
2.7.0
