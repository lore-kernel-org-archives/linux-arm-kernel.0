From: broonie@kernel.org (Mark Brown)
Date: Thu, 03 Nov 2016 14:34:04 -0600
Subject: Applied "ASoC: sun4i-codec: Revise comments for register definition
 macros" to the asoc tree
In-Reply-To: <20161103075556.29018-4-wens@csie.org>
Message-ID: <E1c2Oi4-0004RL-TQ@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Revise comments for register definition macros

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

>From bd720ecf4ec6923207b4059ff4b4a43ee25ac891 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Nov 2016 15:55:45 +0800
Subject: [PATCH] ASoC: sun4i-codec: Revise comments for register definition
 macros

This revises existing comments in the register definition macros
section, and adds a few more, so that readers can clearly identify
the types of control registers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 7b78f4045d38..969d86b4cd44 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -38,7 +38,7 @@
 #include <sound/initval.h>
 #include <sound/dmaengine_pcm.h>
 
-/* Codec DAC register offsets and bit fields */
+/* Codec DAC digital controls and FIFO registers */
 #define SUN4I_CODEC_DAC_DPC			(0x00)
 #define SUN4I_CODEC_DAC_DPC_EN_DA			(31)
 #define SUN4I_CODEC_DAC_DPC_DVOL			(12)
@@ -55,6 +55,8 @@
 #define SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH		(0)
 #define SUN4I_CODEC_DAC_FIFOS			(0x08)
 #define SUN4I_CODEC_DAC_TXDATA			(0x0c)
+
+/* Codec DAC side analog signal controls */
 #define SUN4I_CODEC_DAC_ACTL			(0x10)
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
@@ -69,7 +71,7 @@
 #define SUN4I_CODEC_DAC_TUNE			(0x14)
 #define SUN4I_CODEC_DAC_DEBUG			(0x18)
 
-/* Codec ADC register offsets and bit fields */
+/* Codec ADC digital controls and FIFO registers */
 #define SUN4I_CODEC_ADC_FIFOC			(0x1c)
 #define SUN4I_CODEC_ADC_FIFOC_ADC_FS			(29)
 #define SUN4I_CODEC_ADC_FIFOC_EN_AD			(28)
@@ -81,6 +83,8 @@
 #define SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH		(0)
 #define SUN4I_CODEC_ADC_FIFOS			(0x20)
 #define SUN4I_CODEC_ADC_RXDATA			(0x24)
+
+/* Codec ADC side analog signal controls */
 #define SUN4I_CODEC_ADC_ACTL			(0x28)
 #define SUN4I_CODEC_ADC_ACTL_ADC_R_EN			(31)
 #define SUN4I_CODEC_ADC_ACTL_ADC_L_EN			(30)
@@ -93,10 +97,14 @@
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
 
-/* Other various ADC registers */
+/* FIFO counters */
 #define SUN4I_CODEC_DAC_TXCNT			(0x30)
 #define SUN4I_CODEC_ADC_RXCNT			(0x34)
+
+/* Calibration register (sun7i only) */
 #define SUN7I_CODEC_AC_DAC_CAL			(0x38)
+
+/* Microphone controls (sun7i only) */
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
 struct sun4i_codec {
-- 
2.10.1
