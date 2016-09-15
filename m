From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 15 Sep 2016 15:28:20 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_EFI
Message-ID: <1473949700-12814-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables CONFIG_EFI for multi_v7_defconfig, which adds support for
booting via EFI, and for the EFI framebuffer as builtin options. It
also enables the EFI rtc, the EFI variable pseudo-filesystem and the
EFI capsule loader as modules.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

We have been happily booting multi_v7_defconfig+CONFIG_EFI=y kernels on
kernelci for months now, so please consider enabling this by default.
The increase in compressed kernel footprint is ~30 KB, for the uncompressed
kernel it's ~10 KB, some of which is .init code.

 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2c8665cd9dc5..f30e8b44ea0d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -129,6 +129,7 @@ CONFIG_CMA=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_KEXEC=y
+CONFIG_EFI=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
@@ -593,6 +594,7 @@ CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_STI=m
 CONFIG_DRM_VC4=y
 CONFIG_FB_ARMCLCD=y
+CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SIMPLE=y
@@ -750,6 +752,7 @@ CONFIG_RTC_DRV_S35390A=m
 CONFIG_RTC_DRV_RX8581=m
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_DA9063=m
+CONFIG_RTC_DRV_EFI=m
 CONFIG_RTC_DRV_DIGICOLOR=m
 CONFIG_RTC_DRV_S5M=m
 CONFIG_RTC_DRV_S3C=m
@@ -867,6 +870,8 @@ CONFIG_NVMEM=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_EFI_VARS=m
+CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.7.4
