From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Oct 2018 11:13:48 -0300
Subject: [PATCH v2 1/6] ARM: imx_v6_v7_defconfig: Re-sync defconfig
Message-ID: <1538576033-23415-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-sync the defconfig by doing:
    
make savedefconfig
cp defconfig arch/arm/configs/imx_v6_v7_defconfig

and only keep the options that were moved around.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Only show the options that were moved around

 arch/arm/configs/imx_v6_v7_defconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index fa1882f..f548fd5 100644
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
@@ -65,9 +60,14 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
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
@@ -428,14 +428,7 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
-CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_PROVE_LOCKING=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_FTRACE is not set
-# CONFIG_ARM_UNWIND is not set
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_SAHARA=y
@@ -446,3 +439,10 @@ CONFIG_LIBCRC32C=m
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
