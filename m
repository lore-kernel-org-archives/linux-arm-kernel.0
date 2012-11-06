From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 06 Nov 2012 10:26:26 +0530
Subject: [PATCH V3] ASoC: Samsung: Update Kconfig for I2S,SPDIF and PCM audio
Message-ID: <1352177786-16505-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Kconfig file to enable I2S,PCM audio for wm8994 and spdif on all
samsung platforms.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

Changes since V2:
	- Made driver selection based on SND_SOC_SAMSUNG as suggested by Olof
	
Changes since V1:
	- Made driver selection based on MACH_EXYNOS5_DT

 sound/soc/samsung/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index e7b8317..9b3b63e 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
 
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 || MACH_SMDK4212)
+	depends on SND_SOC_SAMSUNG
 	depends on I2C=y && GENERIC_HARDIRQS
 	select MFD_WM8994
 	select SND_SOC_WM8994
@@ -162,7 +162,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210 || MACH_SMDKV310 || MACH_SMDK4212)
+	depends on SND_SOC_SAMSUNG
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
@@ -177,7 +177,7 @@ config SND_SOC_SMDK_WM8580_PCM
 
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310 || MACH_SMDK4212)
+	depends on SND_SOC_SAMSUNG
 	depends on I2C=y && GENERIC_HARDIRQS
 	select MFD_WM8994
 	select SND_SOC_WM8994
-- 
1.7.4.4
