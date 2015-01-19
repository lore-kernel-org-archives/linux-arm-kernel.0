From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 Jan 2015 11:43:02 +0100
Subject: [PATCH 4/4] ASoC: samsung: remove outdated Kconfig references
Message-ID: <1421664182.9655.55.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbols MACH_SMDKC110 and MACH_SMDKV210 were removed in
v3.17. But the Kconfig entries for SND_SOC_SAMSUNG_SMDK_WM8580 and
SND_SOC_SAMSUNG_SMDK_WM9713 still reference them.

Perhaps these references to those removed symbols should be changed into
references to an existing symbol (such as MACH_S5PV210_DT). But
apparently no one noticed that these references were pointless ever
since v3.17. So it seems they can simply be removed. Let's do that now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 sound/soc/samsung/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 5f983d064920..01980bb2c6e7 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -53,7 +53,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_SOC_SAMSUNG && MACH_SMDK6410
 	depends on REGMAP_I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
@@ -134,7 +134,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 
 config SND_SOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_SOC_SAMSUNG && MACH_SMDK6410
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
-- 
1.9.3
