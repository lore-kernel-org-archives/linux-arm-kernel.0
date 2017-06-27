From: aravind.thk@gmail.com (Aravind Thokala)
Date: Tue, 27 Jun 2017 21:37:10 +0530
Subject: [PATCH] spi/bcm63xx-hspi: Fix checkpatch warnings
Message-ID: <1498579630-10109-1-git-send-email-aravind.thk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the checkpatch.pl warnings on the driver
file.

Signed-off-by: Aravind Thokala <aravind.thk@gmail.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 5514cd0..17306c1 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -108,7 +108,7 @@ struct bcm63xx_hsspi {
 	u8 cs_polarity;
 };
 
-static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned cs,
+static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned int cs,
 				 bool active)
 {
 	u32 reg;
@@ -127,7 +127,7 @@ static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned cs,
 static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 				  struct spi_device *spi, int hz)
 {
-	unsigned profile = spi->chip_select;
+	unsigned int profile = spi->chip_select;
 	u32 reg;
 
 	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
@@ -154,7 +154,7 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
-	unsigned chip_select = spi->chip_select;
+	unsigned int chip_select = spi->chip_select;
 	u16 opcode = 0;
 	int pending = t->len;
 	int step_size = HSSPI_BUFFER_LEN;
-- 
2.7.4
