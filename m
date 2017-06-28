From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:26:07 +0100
Subject: Applied "spi: rockchip: Set GPIO_SS flag to enable Slave Select with
 GPIO CS" to the spi tree
In-Reply-To: <1498624723-17332-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <E1dQIbH-0004jF-Kd@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: Set GPIO_SS flag to enable Slave Select with GPIO CS

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

>From c863795c4c0787e5f885099e3b673e1433448b82 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Wed, 28 Jun 2017 12:38:42 +0800
Subject: [PATCH] spi: rockchip: Set GPIO_SS flag to enable Slave Select with
 GPIO CS

The rockchip spi still requires slave selection when using GPIO CS.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index bab9b13f0ad0..52ea1605d4c6 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -749,6 +749,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
+	master->flags = SPI_MASTER_GPIO_SS;
 
 	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(rs->dma_tx.ch)) {
-- 
2.13.2
