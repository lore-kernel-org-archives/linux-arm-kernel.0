From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 10 Feb 2017 10:41:32 +0100
Subject: [PATCH 3/4] ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY
In-Reply-To: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
References: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
Message-ID: <20170210094133.11382-4-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SOC_MIXER_ARRAY is a simplified function of SND_SOC_DAPM_MIXER
which handles automatically the ARRAY_SIZE of controls.

Update the driver to use SOC_MIXER_ARRAY.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 107fa8213600..a75a983974d9 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -288,12 +288,10 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			 SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
 
 	/* DAC Mixers */
-	SND_SOC_DAPM_MIXER("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
-			   sun8i_dac_mixer_controls,
-			   ARRAY_SIZE(sun8i_dac_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
-			   sun8i_dac_mixer_controls,
-			   ARRAY_SIZE(sun8i_dac_mixer_controls)),
+	SOC_MIXER_ARRAY("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
+			sun8i_dac_mixer_controls),
+	SOC_MIXER_ARRAY("Right Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
+			sun8i_dac_mixer_controls),
 
 	/* Clocks */
 	SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
-- 
2.11.0
