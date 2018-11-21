From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Nov 2018 21:17:47 -0800
Subject: [PATCH v8 2/7] ASoC: simple-amplifier: add VCC regulator widget
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Message-ID: <20181121051752.18387-3-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amplifier may have assosicated regulator, so add a widget for it
and appropriate route.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
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
