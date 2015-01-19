From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 Jan 2015 11:42:45 +0100
Subject: [PATCH 3/4] ASoC: samsung: MACH_SMDKC100 isn't supported anymore
Message-ID: <1421664165.9655.54.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b8529ec1c1b0 ("ARM: S5PC100: no more support S5PC100 SoC")
removed Kconfig symbol MACH_SMDKC100. But there are still two references
to that symbol left. These are now pointless. Remove them too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Apparently Kukjin had a fixup queued (see
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081482.html ). But that fixup never entered the tree, so let's try again.

 sound/soc/samsung/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 3be649098b30..5f983d064920 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -53,7 +53,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKV210 || MACH_SMDKC110)
 	depends on REGMAP_I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
@@ -134,7 +134,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 
 config SND_SOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKV210 || MACH_SMDKC110)
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
-- 
1.9.3
