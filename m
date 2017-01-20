From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Jan 2017 13:37:06 +0000
Subject: Applied "ASoC: sun4i-spdif: Add support for the H3 SoC" to the asoc
 tree
In-Reply-To: <20170112164516.15877-1-codekipper@gmail.com>
Message-ID: <E1cUZNK-0000fw-TV@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-spdif: Add support for the H3 SoC

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1bd92af877abfeddcc4b83a35482ed4139591acf Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Thu, 19 Jan 2017 20:52:58 +0100
Subject: [PATCH] ASoC: sun4i-spdif: Add support for the H3 SoC

The H3 SoC uses the same SPDIF block as found in earlier SoCs, but its
TXFIFO is mapped to another address.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index fec62ee1fc72..c03cd07a9b19 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -103,6 +103,8 @@
 	#define SUN4I_SPDIF_ISTA_RXOSTA			BIT(1)
 	#define SUN4I_SPDIF_ISTA_RXASTA			BIT(0)
 
+#define SUN8I_SPDIF_TXFIFO	(0x20)
+
 #define SUN4I_SPDIF_TXCNT	(0x24)
 
 #define SUN4I_SPDIF_RXCNT	(0x28)
@@ -417,6 +419,11 @@ static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.has_reset	= true,
 };
 
+static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
+	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
+	.has_reset	= true,
+};
+
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-spdif",
@@ -426,6 +433,10 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun6i-a31-spdif",
 		.data = &sun6i_a31_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-spdif",
+		.data = &sun8i_h3_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
-- 
2.11.0
