From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Mon, 14 Dec 2015 18:39:43 +0530
Subject: [LINUX RFC v3 2/4] mtd: add spi_device instance to spi_nor struct
In-Reply-To: <1450098585-3129-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1450098585-3129-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <1450098585-3129-3-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds struct spi_device instacne to the spi_nor structure.

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
V3 Changes:
	- No change in this patch
V2 Changes:
	- This is new patch, basically splitted on request of Mark Brown
---

 drivers/mtd/devices/m25p80.c | 1 +
 include/linux/mtd/spi-nor.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index fe9ceb7..bab4939 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -204,6 +204,7 @@ static int m25p_probe(struct spi_device *spi)

 	spi_set_drvdata(spi, flash);
 	flash->spi = spi;
+	nor->spi = spi;

 	if (spi->mode & SPI_RX_QUAD)
 		mode = SPI_NOR_QUAD;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index c8723b6..872b2b4 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -155,6 +155,7 @@ struct spi_nor {
 	struct mtd_info		mtd;
 	struct mutex		lock;
 	struct device		*dev;
+	struct spi_device       *spi;
 	struct device_node	*flash_node;
 	u32			page_size;
 	u8			addr_width;
--
2.1.2
