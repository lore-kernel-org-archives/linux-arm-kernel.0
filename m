From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Nov 2018 18:23:21 +0800
Subject: [PATCH v9 4/8] ASoC: simple-amplifier: add VCC regulator widget
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Message-ID: <20181122102325.29495-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Amplifier may have assosicated regulator, so add a widget for it
and appropriate route.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/codecs/simple-amplifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index 85524acf3e9c..c07e8a80b4b7 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -19,6 +19,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <sound/soc.h>
 
 #define DRV_NAME "simple-amplifier"
@@ -58,11 +59,14 @@ static const struct snd_soc_dapm_widget simple_amp_dapm_widgets[] = {
 			       (SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)),
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VCC", 20, 0),
 };
 
 static const struct snd_soc_dapm_route simple_amp_dapm_routes[] = {
 	{ "DRV", NULL, "INL" },
 	{ "DRV", NULL, "INR" },
+	{ "OUTL", NULL, "VCC" },
+	{ "OUTR", NULL, "VCC" },
 	{ "OUTL", NULL, "DRV" },
 	{ "OUTR", NULL, "DRV" },
 };
-- 
2.19.1
