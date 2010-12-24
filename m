From: sw.youn@samsung.com (Seungwhan Youn)
Date: Fri, 24 Dec 2010 15:42:18 +0900
Subject: [PATCH 2/4] ARM: SAMSUNG: Add SMDK audio configuration
In-Reply-To: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1293172938-23615-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SMDK audio select configurations based on platform dependacny.
This helps more easyly and clearly to make sure about configuration on audio
drivers support on platform side.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 arch/arm/mach-s3c2443/Kconfig |    1 +
 arch/arm/mach-s3c64xx/Kconfig |    3 +++
 arch/arm/mach-s5p6442/Kconfig |    2 ++
 arch/arm/mach-s5p64x0/Kconfig |    4 ++++
 arch/arm/mach-s5pc100/Kconfig |    4 ++++
 arch/arm/mach-s5pv210/Kconfig |    8 ++++++++
 arch/arm/mach-s5pv310/Kconfig |    8 ++++++++
 7 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
index 31babec..8a3052f 100644
--- a/arch/arm/mach-s3c2443/Kconfig
+++ b/arch/arm/mach-s3c2443/Kconfig
@@ -26,6 +26,7 @@ config MACH_SMDK2443
 	select CPU_S3C2443
 	select MACH_SMDK
 	select S3C_DEV_HSMMC
+	select SMDK_HAS_WM9710_AC97 if ASOC_SAMSUNG
 	help
 	  Say Y here if you are using an SMDK2443
 
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 579d2f0..02caae9 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -149,6 +149,9 @@ config MACH_SMDK6410
 	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
+	select SMDK_HAS_WM8580_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8580_PCM if ASOC_SAMSUNG
+	select SMDK_HAS_WM9713_AC97 if ASOC_SAMSUNG
 	help
 	  Machine support for the Samsung SMDK6410
 
diff --git a/arch/arm/mach-s5p6442/Kconfig b/arch/arm/mach-s5p6442/Kconfig
index 33569e4..24c8131 100644
--- a/arch/arm/mach-s5p6442/Kconfig
+++ b/arch/arm/mach-s5p6442/Kconfig
@@ -19,6 +19,8 @@ config MACH_SMDK6442
 	bool "SMDK6442"
 	select CPU_S5P6442
 	select S3C_DEV_WDT
+	select SMDK_HAS_WM8580_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8580_PCM if ASOC_SAMSUNG
 	help
 	  Machine support for Samsung SMDK6442
 
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 164d278..005f1e5 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -36,6 +36,8 @@ config MACH_SMDK6440
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
+	select SMDK_HAS_WM8580_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8580_PCM if ASOC_SAMSUNG
 	help
 	  Machine support for the Samsung SMDK6440
 
@@ -49,6 +51,8 @@ config MACH_SMDK6450
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
+	select SMDK_HAS_WM8580_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8580_PCM if ASOC_SAMSUNG
 	help
 	  Machine support for the Samsung SMDK6450
 
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index b8fbf2f..fb9befd 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -67,6 +67,10 @@ config MACH_SMDKC100
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
+	select SMDK_HAS_WM8580_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8580_PCM if ASOC_SAMSUNG
+	select SMDK_HAS_WM9713_AC97 if ASOC_SAMSUNG
+	select SMDK_HAS_SPDIF if ASOC_SAMSUNG
 	help
 	  Machine support for the Samsung SMDKC100
 
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 53aabef..44a4e5f 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -107,6 +107,10 @@ config MACH_SMDKC110
 	select S5PV210_SETUP_I2C1
 	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_IDE
+	select SMDK_HAS_WM8580_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8580_PCM if ASOC_SAMSUNG
+	select SMDK_HAS_WM9713_AC97 if ASOC_SAMSUNG
+	select SMDK_HAS_SPDIF if ASOC_SAMSUNG
 	help
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
@@ -137,6 +141,10 @@ config MACH_SMDKV210
 	select S5PV210_SETUP_IDE
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
+	select SMDK_HAS_WM8580_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8580_PCM if ASOC_SAMSUNG
+	select SMDK_HAS_WM9713_AC97 if ASOC_SAMSUNG
+	select SMDK_HAS_SPDIF if ASOC_SAMSUNG
 	help
 	  Machine support for Samsung SMDKV210
 
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index b7aa3cd..ed0926a 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -83,6 +83,10 @@ config MACH_SMDKC210
 	select S5PV310_DEV_PD
 	select S5PV310_SETUP_I2C1
 	select S5PV310_SETUP_SDHCI
+	select SMDK_HAS_WM8994_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8994_PCM if ASOC_SAMSUNG
+	select SMDK_HAS_WM9713_AC97 if ASOC_SAMSUNG
+	select SMDK_HAS_SPDIF if ASOC_SAMSUNG
 	help
 	  Machine support for Samsung SMDKC210
 	  S5PC210(MCP) is one of package option of S5PV310
@@ -118,6 +122,10 @@ config MACH_SMDKV310
 	select S5PV310_DEV_PD
 	select S5PV310_SETUP_I2C1
 	select S5PV310_SETUP_SDHCI
+	select SMDK_HAS_WM8994_I2S if ASOC_SAMSUNG
+	select SMDK_HAS_WM8994_PCM if ASOC_SAMSUNG
+	select SMDK_HAS_WM9713_AC97 if ASOC_SAMSUNG
+	select SMDK_HAS_SPDIF if ASOC_SAMSUNG
 	help
 	  Machine support for Samsung SMDKV310
 
-- 
1.6.2.5
