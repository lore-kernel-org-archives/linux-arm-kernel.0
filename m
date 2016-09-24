From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 24 Sep 2016 22:05:02 +0200
Subject: [PATCH v6 2/3] ASoC: sun4i-codec: Rename some sun7i-only registers
In-Reply-To: <20160924200503.10728-1-dannym@scratchpost.org>
References: <20160924200503.10728-1-dannym@scratchpost.org>
Message-ID: <20160924200503.10728-3-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the registers defined in the driver are only usable on the
A20. Rename these registers.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index c2c0583..3b53b78 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -96,8 +96,8 @@
 /* Other various ADC registers */
 #define SUN4I_CODEC_DAC_TXCNT			(0x30)
 #define SUN4I_CODEC_ADC_RXCNT			(0x34)
-#define SUN4I_CODEC_AC_SYS_VERI			(0x38)
-#define SUN4I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
+#define SUN7I_CODEC_AC_DAC_CAL			(0x38)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
 struct sun4i_codec {
 	struct device	*dev;
@@ -682,7 +682,7 @@ static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-	.max_register	= SUN4I_CODEC_AC_MIC_PHONE_CAL,
+	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
