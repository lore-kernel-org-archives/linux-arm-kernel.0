From: naga.sureshkumar.relli@xilinx.com (Naga Sureshkumar Relli)
Date: Sun, 27 Nov 2016 14:03:30 +0530
Subject: [LINUX RFC v4 2/4] mtd: add spi_device instance to spi_nor struct
Message-ID: <1480235610-33960-1-git-send-email-nagasure@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds struct spi_device instacne to the spi_nor structure.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
Changes for v4:
 - No change
Changes for v3:
 - No change
Changes for v2:
 - This is new patch, basically splitted on request of Mark Brown
---
 drivers/mtd/devices/m25p80.c | 1 +
 include/linux/mtd/spi-nor.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9cf7fcd..58cfb42 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -219,6 +219,7 @@ static int m25p_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, flash);
 	flash->spi = spi;
+	nor->spi = spi;
 
 	if (spi->mode & SPI_RX_QUAD)
 		mode = SPI_NOR_QUAD;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index c425c7b..84f3ce5 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -157,6 +157,7 @@ struct spi_nor {
 	struct mtd_info		mtd;
 	struct mutex		lock;
 	struct device		*dev;
+	struct spi_device       *spi;
 	u32			page_size;
 	u8			addr_width;
 	u8			erase_opcode;
-- 
2.10.2
