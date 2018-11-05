From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:05:51 +0000 (GMT)
Subject: Applied "spi: mediatek: add spi support for mt8183 IC" to the spi tree
In-Reply-To: <1541052139-8845-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20181105120551.59AF31124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: add spi support for mt8183 IC

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

>From b654aa6f2bbb00508ea0abc1cdc98ba8baa13682 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Thu, 1 Nov 2018 14:02:19 +0800
Subject: [PATCH] spi: mediatek: add spi support for mt8183 IC

this patch add support for mt8183 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3dc31627c655..f3119d82150e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -120,6 +120,12 @@ static const struct mtk_spi_compatible mt8173_compat = {
 	.must_tx = true,
 };
 
+static const struct mtk_spi_compatible mt8183_compat = {
+	.need_pad_sel = true,
+	.must_tx = true,
+	.enhance_timing = true,
+};
+
 /*
  * A piece of default chip info unless the platform
  * supplies it.
@@ -150,6 +156,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt8173-spi",
 		.data = (void *)&mt8173_compat,
 	},
+	{ .compatible = "mediatek,mt8183-spi",
+		.data = (void *)&mt8183_compat,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
-- 
2.19.0.rc2
