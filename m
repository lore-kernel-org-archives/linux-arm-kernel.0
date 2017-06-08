From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:44 +0200
Subject: [PATCH 33/35] ARM: s3c6400_defconfig: Save defconfig
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-33-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generate new defconfig to get rid of obsolete Kconfig entries:
 - S3C_BOOT_ERROR_RESET, SND_S3C24XX_SOC and SND_SOC_SMDK_WM9713 are
   gone;
 - rest of entries is being removed by default values;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/s3c6400_defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 8979e343d255..507d7ad7523a 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -8,7 +8,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_MULTI_V6=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_S3C64XX=y
-CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_MACH_SMDK6400=y
 CONFIG_MACH_ANW6410=y
 CONFIG_MACH_MINI6410=y
@@ -19,11 +18,9 @@ CONFIG_MACH_HMT=y
 CONFIG_MACH_SMARTQ5=y
 CONFIG_MACH_SMARTQ7=y
 CONFIG_MACH_WLF_CRAGG_6410=y
-CONFIG_CPU_32v6K=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x51000000,6M ramdisk_size=6144"
 CONFIG_VFP=y
-CONFIG_PM=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_NAND=y
@@ -48,14 +45,11 @@ CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_LTV350QV=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SOC=m
-CONFIG_SND_S3C24XX_SOC=m
-CONFIG_SND_SOC_SMDK_WM9713=m
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.9.3
