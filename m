From: vigneshr@ti.com (Vignesh R)
Date: Wed, 7 Nov 2018 16:09:26 +0530
Subject: [PATCH 2/2] spi: Kconfig: Enable McSPI driver for K3 platforms
In-Reply-To: <20181107103926.32550-1-vigneshr@ti.com>
References: <20181107103926.32550-1-vigneshr@ti.com>
Message-ID: <20181107103926.32550-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable McSPI driver to be built for K3 platforms, to support McSPI on
AM654 SoC of K3 family.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7d3a5c94727e..51e620264b62 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -435,7 +435,7 @@ config SPI_OMAP_UWIRE
 
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select SG_SPLIT
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
-- 
2.19.1
