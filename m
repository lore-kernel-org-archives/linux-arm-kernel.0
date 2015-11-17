From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 17 Nov 2015 02:42:58 +0100
Subject: [PATCH] ARM: sunxi: Re-enable SID driver in sunxi_defconfig
Message-ID: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
framework") moved the the sunxi SID driver to a new framework, but left
sunxi_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
instead of the new symbold NVMEM_SUNXI_SID. Hence, re-enable the driver
in sunxi_defconfig.

While at it, clean up sunxi_defconfig by generating a fresh file via
  make sunxi_defconfig
  make savedefconfig
While this moves around a few lines and removes unnecessary symbols,
it doesn't introduce any functional changes.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3c36e16..904ea52 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -11,14 +11,12 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -37,7 +35,6 @@ CONFIG_CAN_SUN4I=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_EEPROM_SUNXI_SID=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_AHCI_SUNXI=y
@@ -63,11 +60,10 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
-CONFIG_INPUT_MISC=y
-CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_KEYBOARD_SUN4I_LRADC=y
 CONFIG_TOUCHSCREEN_SUN4I=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
@@ -123,6 +119,8 @@ CONFIG_PWM=y
 CONFIG_PWM_SUN4I=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
+CONFIG_NVMEM=y
+CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.1.4
