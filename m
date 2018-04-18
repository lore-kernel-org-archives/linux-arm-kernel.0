From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Apr 2018 12:40:53 +0100
Subject: Applied "spi: spi-s3c64xx: Drop unused enable_datapath() function
 argument" to the spi tree
In-Reply-To: <20180417142954.5507-4-s.nawrocki@samsung.com>
Message-ID: <E1f8lSH-00027l-AH@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-s3c64xx: Drop unused enable_datapath() function argument

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 80aa0d746c10e14ac14ca03b2bc8b26a0f75c5e4 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 17 Apr 2018 16:29:50 +0200
Subject: [PATCH] spi: spi-s3c64xx: Drop unused enable_datapath() function
 argument

The spi pointer argument is not used now so remove it.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 54fde5c80374..38a5e9ce5f11 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -349,8 +349,7 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 }
 
 static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-				struct spi_device *spi,
-				struct spi_transfer *xfer, int dma_mode)
+			    struct spi_transfer *xfer, int dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
@@ -667,7 +666,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	sdd->state &= ~RXBUSY;
 	sdd->state &= ~TXBUSY;
 
-	enable_datapath(sdd, spi, xfer, use_dma);
+	enable_datapath(sdd, xfer, use_dma);
 
 	/* Start the signals */
 	s3c64xx_spi_set_cs(spi, true);
-- 
2.17.0
