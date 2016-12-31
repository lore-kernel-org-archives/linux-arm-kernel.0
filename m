From: broonie@kernel.org (Mark Brown)
Date: Sat, 31 Dec 2016 19:19:07 +0000
Subject: Applied "ASoC: sun4i-spdif: remove legacy dapm components" to the
 asoc tree
In-Reply-To: <20161220144914.30945-2-codekipper@gmail.com>
Message-ID: <E1cNPBL-0003tB-IO@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-spdif: remove legacy dapm components

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

>From 96e53c41e1f81c9e9d1ce38d3f28b95668b71dcf Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Tue, 20 Dec 2016 15:49:13 +0100
Subject: [PATCH] ASoC: sun4i-spdif: remove legacy dapm components

The dapm components are now handled by the ALSA SoC SPDIF DIT driver
so can be removed.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 88fbb3a1e660..048de15d6937 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -403,14 +403,6 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
-static const struct snd_soc_dapm_widget dit_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("spdif-out"),
-};
-
-static const struct snd_soc_dapm_route dit_routes[] = {
-	{ "spdif-out", NULL, "Playback" },
-};
-
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-spdif", },
 	{ .compatible = "allwinner,sun6i-a31-spdif", },
-- 
2.11.0
