From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:45:09 +0530
Subject: [PATCH 2/2] ASoC: codecs: make snd_soc_dai_driver and
 snd_soc_component_driver const
In-Reply-To: <1502903709-7411-1-git-send-email-bhumirks@gmail.com>
References: <1502903709-7411-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502903709-7411-3-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these two structure variables const as they are either used in a
copy operation or passed to devm_snd_soc_register_component having the
corresponding argument as const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 sound/soc/codecs/lm4857.c     | 2 +-
 sound/soc/codecs/max9768.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 7aba4f3..ce1be8b 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -692,7 +692,7 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	return snd_ctl_add(rtd->card->snd_card, kctl);
 }
 
-static struct snd_soc_dai_driver hdmi_i2s_dai = {
+static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
 	.playback = {
diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 558de10..1e96407 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -100,7 +100,7 @@ static SOC_VALUE_ENUM_SINGLE_AUTODISABLE_DECL(lm4857_mode_enum,
 	{ "EP", "Earpiece", "Mode" },
 };
 
-static struct snd_soc_component_driver lm4857_component_driver = {
+static const struct snd_soc_component_driver lm4857_component_driver = {
 	.controls = lm4857_controls,
 	.num_controls = ARRAY_SIZE(lm4857_controls),
 	.dapm_widgets = lm4857_dapm_widgets,
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 5b82e26..7017c03 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -151,7 +151,7 @@ static int max9768_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static struct snd_soc_component_driver max9768_component_driver = {
+static const struct snd_soc_component_driver max9768_component_driver = {
 	.probe = max9768_probe,
 	.controls = max9768_volume,
 	.num_controls = ARRAY_SIZE(max9768_volume),
-- 
1.9.1
