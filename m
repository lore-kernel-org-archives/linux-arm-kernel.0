From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:09 +0200
Subject: [PATCH 05/12] sun4i-codec: Move struct sun4i_codec_quirks further up.
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-6-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 25870a64..f56a59ad 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -889,6 +889,16 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
 };
 
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+	const struct snd_soc_codec_driver *codec;
+	struct snd_soc_card * (*create_card)(struct device *dev);
+	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
+	bool has_reset;
+};
+
 static struct snd_soc_codec_driver sun4i_codec_codec = {
 	.component_driver = {
 		.controls		= sun4i_codec_controls,
@@ -1546,16 +1556,6 @@ static const struct regmap_config sun8i_v3s_codec_regmap_config = {
 	.max_register	= SUN8I_H3_CODEC_ADC_DBG,
 };
 
-struct sun4i_codec_quirks {
-	const struct regmap_config *regmap_config;
-	const struct snd_soc_codec_driver *codec;
-	struct snd_soc_card * (*create_card)(struct device *dev);
-	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.regmap_config	= &sun4i_codec_regmap_config,
 	.codec		= &sun4i_codec_codec,
