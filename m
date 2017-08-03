From: bhumirks@gmail.com (Bhumika Goyal)
Date: Thu,  3 Aug 2017 21:30:20 +0530
Subject: [PATCH 2/2] ASoC: sunxi: make snd_soc_codec_driver structures as const
In-Reply-To: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
References: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1501776020-3328-3-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare snd_soc_codec_driver structures as const as they are either
passed as an argument to the function snd_soc_register_codec or stored as
reference in field codec of type sun4i_codec_quirks. Both the fucntion
argument and the codec field are of type const, so declare the
structures with this property as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 6 +++---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 73d054f..c668b8b 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -762,7 +762,7 @@ static void sun4i_codec_shutdown(struct snd_pcm_substream *substream,
 	{ "Mic1", NULL, "VMIC" },
 };
 
-static struct snd_soc_codec_driver sun4i_codec_codec = {
+static const struct snd_soc_codec_driver sun4i_codec_codec = {
 	.component_driver = {
 		.controls		= sun4i_codec_controls,
 		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
@@ -1068,7 +1068,7 @@ static const DECLARE_TLV_DB_RANGE(sun6i_codec_mic_gain_scale,
 	{ "Right ADC", NULL, "Right ADC Mixer" },
 };
 
-static struct snd_soc_codec_driver sun6i_codec_codec = {
+static const struct snd_soc_codec_driver sun6i_codec_codec = {
 	.component_driver = {
 		.controls		= sun6i_codec_codec_widgets,
 		.num_controls		= ARRAY_SIZE(sun6i_codec_codec_widgets),
@@ -1096,7 +1096,7 @@ static const DECLARE_TLV_DB_RANGE(sun6i_codec_mic_gain_scale,
 
 };
 
-static struct snd_soc_codec_driver sun8i_a23_codec_codec = {
+static const struct snd_soc_codec_driver sun8i_a23_codec_codec = {
 	.component_driver = {
 		.controls		= sun8i_a23_codec_codec_controls,
 		.num_controls		= ARRAY_SIZE(sun8i_a23_codec_codec_controls),
diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 253ae0b..abfb710 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -360,7 +360,7 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 	.ops = &sun8i_codec_dai_ops,
 };
 
-static struct snd_soc_codec_driver sun8i_soc_codec = {
+static const struct snd_soc_codec_driver sun8i_soc_codec = {
 	.component_driver = {
 		.dapm_widgets		= sun8i_codec_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
-- 
1.9.1
