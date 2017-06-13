From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 22:09:39 +0100
Subject: Applied "spi: mediatek: add spi support for mt7622 IC" to the spi tree
In-Reply-To: <1497230680-20448-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <E1dKt4F-0000n2-CR@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: add spi support for mt7622 IC

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

>From fc4f226fece3d09d1014c2e98b5accc874a62617 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Mon, 12 Jun 2017 09:24:40 +0800
Subject: [PATCH] spi: mediatek: add spi support for mt7622 IC

this patch add support for mt7622 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index eae73b58248b..ec7755b7a94b 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -104,6 +104,12 @@ struct mtk_spi {
 };
 
 static const struct mtk_spi_compatible mtk_common_compat;
+
+static const struct mtk_spi_compatible mt7622_compat = {
+	.must_tx = true,
+	.enhance_timing = true,
+};
+
 static const struct mtk_spi_compatible mt8173_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
@@ -127,6 +133,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt6589-spi",
 		.data = (void *)&mtk_common_compat,
 	},
+	{ .compatible = "mediatek,mt7622-spi",
+		.data = (void *)&mt7622_compat,
+	},
 	{ .compatible = "mediatek,mt8135-spi",
 		.data = (void *)&mtk_common_compat,
 	},
-- 
2.11.0
