From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jul 2017 19:42:44 +0100
Subject: Applied "spi/bcm63xx-hspi: Fix checkpatch warnings" to the spi tree
In-Reply-To: <1498579630-10109-1-git-send-email-aravind.thk@gmail.com>
Message-ID: <E1dUdds-0000NA-Dt@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi/bcm63xx-hspi: Fix checkpatch warnings

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 92bd7c3b8612f6e753b8d8805d89a2e425a88fec Mon Sep 17 00:00:00 2001
From: Aravind Thokala <aravind.thk@gmail.com>
Date: Tue, 27 Jun 2017 21:37:10 +0530
Subject: [PATCH] spi/bcm63xx-hspi: Fix checkpatch warnings

This patch fixes the checkpatch.pl warnings on the driver
file.

Signed-off-by: Aravind Thokala <aravind.thk@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 4da2d4a524ca..475a79015aa6 100644
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
2.13.2
