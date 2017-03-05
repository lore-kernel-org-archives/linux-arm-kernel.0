From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  5 Mar 2017 21:37:01 +0800
Subject: [PATCH v2 04/12] ASoC: sun8i-codec-analog: add support for V3s SoC
In-Reply-To: <20170305133709.6288-1-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
Message-ID: <20170305133709.6288-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V3s SoC features an analog codec with headphone support but without
mic2 and linein.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt | 1 +
 sound/soc/sunxi/sun8i-codec-analog.c                           | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
index 779b735781ba..1b6e7c4e50ab 100644
--- a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: must be one of the following compatibles:
 		- "allwinner,sun8i-a23-codec-analog"
 		- "allwinner,sun8i-h3-codec-analog"
+		- "allwinner,sun8i-v3s-codec-analog"
 
 Required properties if not a sub-node of the PRCM node:
 - reg: must contain the registers location and length
diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index af56afe5c403..d87c75c6ad8e 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -713,6 +713,11 @@ static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
 	.has_mic2	= true,
 };
 
+static const struct sun8i_codec_analog_quirks sun8i_v3s_quirks = {
+	.has_headphone	= true,
+	.has_hmic	= true,
+};
+
 static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 {
 	struct device *dev = cmpnt->dev;
@@ -786,6 +791,10 @@ static const struct of_device_id sun8i_codec_analog_of_match[] = {
 		.compatible = "allwinner,sun8i-h3-codec-analog",
 		.data = &sun8i_h3_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-v3s-codec-analog",
+		.data = &sun8i_v3s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun8i_codec_analog_of_match);
-- 
2.11.1
