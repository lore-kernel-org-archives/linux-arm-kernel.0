From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  3 Jul 2014 07:40:17 +0900
Subject: [PATCH v2 04/17] ASoC: samsung: no more support for S5P6440 and
 S5P6450 SoCs
Message-ID: <1404340817-28902-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes s5p64x0 related WM8580 because of removing support
for s5p64x0 SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mark Brown <broonie@linaro.org>
[pebolle at tiscali.nl: reported missing dependency for smdk6450]
Reported-by: Paul Bolle <pebolle@tiscali.nl>
---
 sound/soc/samsung/Kconfig          | 4 ++--
 sound/soc/samsung/smdk_wm8580pcm.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 753b8c9..4f8d22f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
 	depends on REGMAP_I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
@@ -178,7 +178,7 @@ config SND_SOC_SAMSUNG_SMDK_SPDIF
 
 config SND_SOC_SMDK_WM8580_PCM
 	tristate "SoC PCM Audio support for WM8580 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6450 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDKV210 || MACH_SMDKC110)
 	depends on REGMAP_I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_PCM
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index e119aaa..63d0793 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -25,7 +25,7 @@
  *  o '0' means 'OFF'
  *  o 'X' means 'Don't care'
  *
- * SMDK6410, SMDK6440, SMDK6450 Base B/D: CFG1-0000, CFG2-1111
+ * SMDK6410 Base B/D: CFG1-0000, CFG2-1111
  * SMDKC110, SMDKV210: CFGB11-100100, CFGB12-0000
  */
 
-- 
1.8.2.1.339.g52a3e01
