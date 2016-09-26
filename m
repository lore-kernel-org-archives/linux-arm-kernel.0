From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Sep 2016 09:43:55 -0700
Subject: Applied "ASoC: sun4i-codec: Rename sun4i_codec_widgets for
 consistency" to the asoc tree
In-Reply-To: <20160915143922.4890-2-dannym@scratchpost.org>
Message-ID: <E1boZ0V-0007DI-BU@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Rename sun4i_codec_widgets for consistency

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

>From c9e902f4b37a3c108eb5dc51f1340c09becd7232 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Sat, 24 Sep 2016 22:05:01 +0200
Subject: [PATCH] ASoC: sun4i-codec: Rename sun4i_codec_widgets for consistency

Rename "sun4i_codec_widgets" to "sun4i_codec_controls" for
consistency with the struct field name.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index e51f363ff786..e047ec06d538 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -509,7 +509,7 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 
-static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
+static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
@@ -629,8 +629,8 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
 	.component_driver = {
-		.controls		= sun4i_codec_widgets,
-		.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
+		.controls		= sun4i_codec_controls,
+		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
 		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
 		.dapm_routes		= sun4i_codec_codec_dapm_routes,
-- 
2.9.3
