From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 14 Apr 2016 20:14:26 +0800
Subject: [alsa-devel] [RFC PATCH v2 1/5] ASoC: Mediatek: Refine mt8173 driver
In-Reply-To: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
References: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1460636070-37426-2-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move mt8173 driver to another folder.

The software control sequence of mt2701 is very different from that of mt8173,
so this patch moves mt8173 code to another folder.


Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/Makefile                            | 12 +++++-------
 sound/soc/mediatek/mt8173/Makefile                     |  7 +++++++
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c      |  2 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c |  2 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c |  4 ++--
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c        |  2 +-
 sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h       |  0
 sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c          |  0
 8 files changed, 17 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h (100%)
 rename sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c (100%)

diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index d486860..5048165 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -1,7 +1,5 @@
-# MTK Platform Support
-obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
-# Machine support
-obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
-obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
-obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173-rt5650-rt5514.o
-obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
+# 8173 Machine support
+obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173/
+obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173/
+obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173/
+obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173/
diff --git a/sound/soc/mediatek/mt8173/Makefile b/sound/soc/mediatek/mt8173/Makefile
new file mode 100644
index 0000000..d486860
--- /dev/null
+++ b/sound/soc/mediatek/mt8173/Makefile
@@ -0,0 +1,7 @@
+# MTK Platform Support
+obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
+# Machine support
+obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173-rt5650-rt5514.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-max98090.c
rename to sound/soc/mediatek/mt8173/mt8173-max98090.c
index 71a1a35..5524a2c 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -18,7 +18,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include <linux/gpio.h>
-#include "../codecs/max98090.h"
+#include "../../codecs/max98090.h"
 
 static struct snd_soc_jack mt8173_max98090_jack;
 
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-rt5650-rt5514.c
rename to sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 58e0836..467f704 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -19,7 +19,7 @@
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/rt5645.h"
+#include "../../codecs/rt5645.h"
 
 #define MCLK_FOR_CODECS		12288000
 
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-rt5650-rt5676.c
rename to sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 5c4c58c..cfa23d9 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -19,8 +19,8 @@
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/rt5645.h"
-#include "../codecs/rt5677.h"
+#include "../../codecs/rt5645.h"
+#include "../../codecs/rt5677.h"
 
 #define MCLK_FOR_CODECS		12288000
 
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-rt5650.c
rename to sound/soc/mediatek/mt8173/mt8173-rt5650.c
index bb09bb1..20b3b7d 100644
--- a/sound/soc/mediatek/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -19,7 +19,7 @@
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/rt5645.h"
+#include "../../codecs/rt5645.h"
 
 #define MCLK_FOR_CODECS		12288000
 
diff --git a/sound/soc/mediatek/mtk-afe-common.h b/sound/soc/mediatek/mt8173/mtk-afe-common.h
similarity index 100%
rename from sound/soc/mediatek/mtk-afe-common.h
rename to sound/soc/mediatek/mt8173/mtk-afe-common.h
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mt8173/mtk-afe-pcm.c
similarity index 100%
rename from sound/soc/mediatek/mtk-afe-pcm.c
rename to sound/soc/mediatek/mt8173/mtk-afe-pcm.c
-- 
1.9.1
