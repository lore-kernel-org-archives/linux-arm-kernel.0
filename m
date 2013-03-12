From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 17:46:56 +0100
Subject: [PATCH v2 13/13] ARM: spear: enable spear13xx in multi_v7_defconfig
In-Reply-To: <1363106816-9603-1-git-send-email-arnd@arndb.de>
References: <1363106816-9603-1-git-send-email-arnd@arndb.de>
Message-ID: <1363106816-9603-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPEAr13xx can now be part of the regular multiplatform defconfig,
so let's enable it there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e31d442..3bf0c54 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -10,6 +10,10 @@ CONFIG_ARCH_SUNXI=y
 # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
 CONFIG_ARCH_ZYNQ=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_PLAT_SPEAR=y
+CONFIG_ARCH_SPEAR13XX=y
+CONFIG_MACH_SPEAR1310=y
+CONFIG_MACH_SPEAR1340=y
 CONFIG_SMP=y
 CONFIG_ARM_ARCH_TIMER=y
 CONFIG_AEABI=y
@@ -23,6 +27,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
+CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_SMSC911X=y
@@ -31,6 +36,7 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
+CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
@@ -40,6 +46,7 @@ CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
+CONFIG_GPIO_PL061=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -50,6 +57,7 @@ CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
@@ -58,3 +66,4 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
+CONFIG_DW_DMAC=y
-- 
1.8.1.2
