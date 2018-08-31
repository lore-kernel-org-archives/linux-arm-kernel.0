From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 31 Aug 2018 10:07:45 -0300
Subject: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Re-sync defconfig
Message-ID: <1535720867-4714-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Re-sync the defconfig by doing:
    
make savedefconfig
cp defconfig arch/arm/configs/imx_v6_v7_defconfig

This helps making further imx_v6_v7_defconfig changes to be cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c21359d..a4ba8c0 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -2,6 +2,7 @@ CONFIG_KERNEL_LZO=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=18
@@ -12,11 +13,6 @@ CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_MX31LILLY=y
@@ -48,7 +44,6 @@ CONFIG_PCI_MSI=y
 CONFIG_PCI_IMX6=y
 CONFIG_SMP=y
 CONFIG_ARM_PSCI=y
-CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_HIGHMEM=y
 CONFIG_FORCE_MAX_ZONEORDER=14
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
@@ -64,9 +59,14 @@ CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_BINFMT_MISC=m
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TEST_SUSPEND=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_BINFMT_MISC=m
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -305,7 +305,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -342,7 +341,6 @@ CONFIG_USB_GADGETFS=m
 CONFIG_USB_FUNCTIONFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
-CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
@@ -424,14 +422,6 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_PROVE_LOCKING=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_FTRACE is not set
-# CONFIG_ARM_UNWIND is not set
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_SAHARA=y
@@ -442,3 +432,10 @@ CONFIG_LIBCRC32C=m
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_PROVE_LOCKING=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_FTRACE is not set
+# CONFIG_ARM_UNWIND is not set
-- 
2.7.4
