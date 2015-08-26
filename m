From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Wed, 26 Aug 2015 11:56:05 +0530
Subject: [LINUX RFC v2 2/4] mtd: add spi_device instance to spi_nor struct
In-Reply-To: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <1440570367-22569-3-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds struct spi_device instacne to the spi_nor structure

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
V2 Changes:
This is new patch, basically splitted on request of Mark Brown
---
 drivers/mtd/devices/m25p80.c | 1 +
 include/linux/mtd/spi-nor.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index d313f948b..174ed0f 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -207,6 +207,7 @@ static int m25p_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, flash);
 	flash->mtd.priv = nor;
 	flash->spi = spi;
+	nor->spi = spi;

 	if (spi->mode & SPI_RX_QUAD)
 		mode = SPI_NOR_QUAD;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e540952..1705dc3 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -163,6 +163,7 @@ struct spi_nor {
 	struct mtd_info		*mtd;
 	struct mutex		lock;
 	struct device		*dev;
+	struct spi_device	*spi;
 	u32			page_size;
 	u8			addr_width;
 	u8			erase_opcode;
--
2.1.2
