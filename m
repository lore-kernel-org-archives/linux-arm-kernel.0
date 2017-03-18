From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Sat, 18 Mar 2017 08:55:05 +0100
Subject: [PATCH v3 1/5] ASoC: sun8i-codec: Remove analog "HP" widget
In-Reply-To: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
Message-ID: <20170318075509.3836-2-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "HP" widget is already present and take part to
the analog part (sun8i-codec-analog).

Remove it from the digital part as it is unnecessary.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index b92bdc8361af..d60f6fbd36a2 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -321,8 +321,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_MOD_RST_CTL_AIF1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("RST DAC", SUN8I_MOD_RST_CTL,
 			    SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
-
-	SND_SOC_DAPM_OUTPUT("HP"),
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
@@ -344,10 +342,6 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	/* DAC Mixer Routes */
 	{ "Left DAC Mixer", "LSlot 0", "Digital Left DAC"},
 	{ "Right DAC Mixer", "RSlot 0", "Digital Right DAC"},
-
-	/* End of route : HP out */
-	{ "HP", NULL, "Left DAC Mixer" },
-	{ "HP", NULL, "Right DAC Mixer" },
 };
 
 static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
-- 
2.11.0
