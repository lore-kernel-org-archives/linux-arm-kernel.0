From: sw.youn@samsung.com (Seungwhan Youn)
Date: Fri, 24 Dec 2010 15:57:20 +0900
Subject: [PATCH 4/4] ASoC: SAMSUNG: Apply modifications for SMDK audio
	configuations
In-Reply-To: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1293173840-6138-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch apply SMDK audio configurations which depends on platform
configurations. This makes more seperate select audio configurations,
because after apply this audio configuration does not consider about
which SMDK board or ARCH is selected.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/samsung/Kconfig |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 90fe869..163dceb 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -33,6 +33,27 @@ config SND_SAMSUNG_SPDIF
 config SND_SAMSUNG_I2S
 	tristate
 
+config SMDK_HAS_WM8580_I2S
+	bool
+
+config SMDK_HAS_WM8994_I2S
+	bool
+
+config SMDK_HAS_WM8580_PCM
+	bool
+
+config SMDK_HAS_WM8994_PCM
+	bool
+
+config SMDK_HAS_WM9710_AC97
+	bool
+
+config SMDK_HAS_WM9713_AC97
+	bool
+
+config SMDK_HAS_SPDIF
+	bool
+
 config ASOC_SAMSUNG_NEO1973_WM8753
 	tristate "SoC I2S Audio support for NEO1973 - WM8753"
 	depends on ASOC_SAMSUNG && MACH_NEO1973_GTA01
@@ -61,7 +82,7 @@ config ASOC_SAMSUNG_JIVE_WM8750
 
 config ASOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450 || MACH_SMDK6442 || MACH_SMDKV210 || MACH_SMDKC110)
+	depends on SMDK_HAS_WM8580_I2S
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
@@ -69,7 +90,7 @@ config ASOC_SAMSUNG_SMDK_WM8580
 
 config ASOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
+	depends on SMDK_HAS_WM8994_I2S
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
 	help
@@ -77,7 +98,7 @@ config ASOC_SAMSUNG_SMDK_WM8994
 
 config ASOC_SAMSUNG_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
-	depends on ASOC_SAMSUNG && MACH_SMDK2443
+	depends on SMDK_HAS_WM9710_AC97
 	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_CODEC
@@ -141,7 +162,7 @@ config ASOC_SAMSUNG_RX1950_UDA1380
 
 config ASOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
+	depends on SMDK_HAS_WM9713_AC97
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
@@ -164,7 +185,7 @@ config ASOC_GONI_AQUILA_WM8994
 
 config ASOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210)
+	depends on SMDK_HAS_SPDIF
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
-- 
1.6.2.5
