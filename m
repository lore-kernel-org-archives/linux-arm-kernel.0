From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 29 Nov 2018 14:29:56 +0800
Subject: [RESEND PATCH 4/4] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
In-Reply-To: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
Message-ID: <d3722d3a7d410f0b47a25363f6d0dc6cd9a7a18e.1543472168.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The quadspi is a generic communication interface which could be shared
with other MediaTek SoCs. Hence rename it to a common one.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mtd/spi-nor/Kconfig  | 16 ++++++++--------
 drivers/mtd/spi-nor/Makefile |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6cc9c92..2062611 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -7,14 +7,6 @@ menuconfig MTD_SPI_NOR
 
 if MTD_SPI_NOR
 
-config MTD_MT81xx_NOR
-	tristate "Mediatek MT81xx SPI NOR flash controller"
-	depends on HAS_IOMEM
-	help
-	  This enables access to SPI NOR flash, using MT81xx SPI NOR flash
-	  controller. This controller does not support generic SPI BUS, it only
-	  supports SPI NOR Flash.
-
 config MTD_SPI_NOR_USE_4K_SECTORS
 	bool "Use small 4096 B erase sectors"
 	default y
@@ -86,6 +78,14 @@ config SPI_NXP_SPIFI
 	  Flash. Enable this option if you have a device with a SPIFI
 	  controller and want to access the Flash as a mtd device.
 
+config SPI_MTK_QUADSPI
+	tristate "MediaTek Quad SPI controller"
+	depends on HAS_IOMEM
+	help
+	  This enables support for the Quad SPI controller in master mode.
+	  This controller does not support generic SPI. It only supports
+	  SPI NOR.
+
 config SPI_INTEL_SPI
 	tristate
 
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index f4c61d2..7f4b6f6 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_SPI_ATMEL_QUADSPI)	+= atmel-quadspi.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
-obj-$(CONFIG_MTD_MT81xx_NOR)    += mtk-quadspi.o
+obj-$(CONFIG_SPI_MTK_QUADSPI)    += mtk-quadspi.o
 obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
 obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
 obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
-- 
1.9.1
