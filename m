From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Nov 2017 20:22:13 +0000
Subject: Applied "spi: meson-axg: add SPICC driver support" to the spi tree
In-Reply-To: <20171128132926.19051-3-yixun.lan@amlogic.com>
Message-ID: <E1eJmOT-0008CS-OP@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: meson-axg: add SPICC driver support

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

>From a5db27c00da37654ba518b814925d4e9cd05259c Mon Sep 17 00:00:00 2001
From: Sunny Luo <sunny.luo@amlogic.com>
Date: Tue, 28 Nov 2017 21:29:25 +0800
Subject: [PATCH] spi: meson-axg: add SPICC driver support

Add new compatible string to support SPICC controller which
found at Amlogic Meson-AXG SoC. This is aiming at adding
a couple of enhanced feature patches.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 7f8429635502..5c82910e3480 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -599,6 +599,7 @@ static int meson_spicc_remove(struct platform_device *pdev)
 
 static const struct of_device_id meson_spicc_of_match[] = {
 	{ .compatible = "amlogic,meson-gx-spicc", },
+	{ .compatible = "amlogic,meson-axg-spicc", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
-- 
2.15.0
