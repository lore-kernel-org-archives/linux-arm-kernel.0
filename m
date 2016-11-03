From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Nov 2016 15:55:45 +0800
Subject: [PATCH v2 03/14] ASoC: sun4i-codec: Revise comments for register
 definition macros
In-Reply-To: <20161103075556.29018-1-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
Message-ID: <20161103075556.29018-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This revises existing comments in the register definition macros
section, and adds a few more, so that readers can clearly identify
the types of control registers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-codec.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index dbb47f255bd8..61ae502a5061 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -40,7 +40,7 @@
 #include <sound/initval.h>
 #include <sound/dmaengine_pcm.h>
 
-/* Codec DAC register offsets and bit fields */
+/* Codec DAC digital controls and FIFO registers */
 #define SUN4I_CODEC_DAC_DPC			(0x00)
 #define SUN4I_CODEC_DAC_DPC_EN_DA			(31)
 #define SUN4I_CODEC_DAC_DPC_DVOL			(12)
@@ -57,6 +57,8 @@
 #define SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH		(0)
 #define SUN4I_CODEC_DAC_FIFOS			(0x08)
 #define SUN4I_CODEC_DAC_TXDATA			(0x0c)
+
+/* Codec DAC side analog signal controls */
 #define SUN4I_CODEC_DAC_ACTL			(0x10)
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
@@ -71,7 +73,7 @@
 #define SUN4I_CODEC_DAC_TUNE			(0x14)
 #define SUN4I_CODEC_DAC_DEBUG			(0x18)
 
-/* Codec ADC register offsets and bit fields */
+/* Codec ADC digital controls and FIFO registers */
 #define SUN4I_CODEC_ADC_FIFOC			(0x1c)
 #define SUN4I_CODEC_ADC_FIFOC_ADC_FS			(29)
 #define SUN4I_CODEC_ADC_FIFOC_EN_AD			(28)
@@ -83,6 +85,8 @@
 #define SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH		(0)
 #define SUN4I_CODEC_ADC_FIFOS			(0x20)
 #define SUN4I_CODEC_ADC_RXDATA			(0x24)
+
+/* Codec ADC side analog signal controls */
 #define SUN4I_CODEC_ADC_ACTL			(0x28)
 #define SUN4I_CODEC_ADC_ACTL_ADC_R_EN			(31)
 #define SUN4I_CODEC_ADC_ACTL_ADC_L_EN			(30)
@@ -95,10 +99,14 @@
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
2.10.2
