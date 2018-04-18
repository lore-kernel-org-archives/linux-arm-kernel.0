From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Apr 2018 12:40:46 +0100
Subject: Applied "spi: pxa2xx: pxa2xx_spi_transfer_one() can be static" to the
 spi tree
In-Reply-To: <20180417195323.GA69680@ivb43>
Message-ID: <E1f8lSA-00025Y-3G@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: pxa2xx_spi_transfer_one() can be static

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

>From 71293a60e38f44b1d18c14803f0dd2744f6b9a12 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Wed, 18 Apr 2018 03:53:23 +0800
Subject: [PATCH] spi: pxa2xx: pxa2xx_spi_transfer_one() can be static

Fixes: d5898e19c0d7 ("spi: pxa2xx: Use core message processing loop")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c852ea5c28c6..40f1346b8188 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -911,9 +911,9 @@ static bool pxa2xx_spi_can_dma(struct spi_controller *master,
 	       xfer->len >= chip->dma_burst_size;
 }
 
-int pxa2xx_spi_transfer_one(struct spi_controller *master,
-			    struct spi_device *spi,
-			    struct spi_transfer *transfer)
+static int pxa2xx_spi_transfer_one(struct spi_controller *master,
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(master);
 	struct spi_message *message = master->cur_msg;
-- 
2.17.0
