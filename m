From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Jun 2017 12:16:55 +0100
Subject: Applied "spi/bcm63xx: Fix checkpatch warnings" to the spi tree
In-Reply-To: <1497890980-4334-1-git-send-email-aravind.thk@gmail.com>
Message-ID: <E1dNdd1-0004O6-8u@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi/bcm63xx: Fix checkpatch warnings

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

>From b85d65dd47e1606299dc054d2162b795df65c94a Mon Sep 17 00:00:00 2001
From: Aravind Thokala <aravind.thk@gmail.com>
Date: Mon, 19 Jun 2017 23:47:48 +0530
Subject: [PATCH] spi/bcm63xx: Fix checkpatch warnings

This patch fixes the checkpatch.pl warnings on the driver
file.

Signed-off-by: Aravind Thokala <aravind.thk@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 247f71b02235..84c7356ce5b4 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -147,7 +147,7 @@ struct bcm63xx_spi {
 
 	/* Platform data */
 	const unsigned long	*reg_offsets;
-	unsigned		fifo_size;
+	unsigned int		fifo_size;
 	unsigned int		msg_type_shift;
 	unsigned int		msg_ctl_width;
 
@@ -191,7 +191,7 @@ static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
 #endif
 }
 
-static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
+static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
 	{ 20000000, SPI_CLK_20MHZ },
 	{ 12500000, SPI_CLK_12_50MHZ },
 	{  6250000, SPI_CLK_6_250MHZ },
-- 
2.11.0
