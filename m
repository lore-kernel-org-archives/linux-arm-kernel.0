From: broonie@kernel.org (Mark Brown)
Date: Wed, 08 Mar 2017 14:22:37 +0100
Subject: Applied "ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY" to the asoc
 tree
In-Reply-To: <20170210094133.11382-4-mylene.josserand@free-electrons.com>
Message-ID: <E1clbY5-0000Bz-OU@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY

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

>From fa22ca4f905d7001ed966bc95bcffb890a1b8d73 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Fri, 10 Feb 2017 10:41:32 +0100
Subject: [PATCH] ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SOC_MIXER_ARRAY is a simplified function of SND_SOC_DAPM_MIXER
which handles automatically the ARRAY_SIZE of controls.

Update the driver to use SOC_MIXER_ARRAY.

Signed-off-by: Myl??ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
