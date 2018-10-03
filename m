From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Oct 2018 11:13:52 -0300
Subject: [PATCH v2 5/6] ARM: imx_v4_v5_defconfig: Re-sync defconfig
In-Reply-To: <1538576033-23415-1-git-send-email-festevam@gmail.com>
References: <1538576033-23415-1-git-send-email-festevam@gmail.com>
Message-ID: <1538576033-23415-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-sync the defconfig by doing:
    
make savedefconfig
cp defconfig arch/arm/configs/imx_v4_v5_defconfig

and only keep the options that were moved around.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Only show the options that were moved around

 arch/arm/configs/imx_v4_v5_defconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 4cd2f4a..eed5ef0 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
@@ -10,13 +11,6 @@ CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -29,11 +23,17 @@ CONFIG_MACH_PCA100=y
 CONFIG_MACH_IMX27_DT=y
 CONFIG_SOC_IMX1=y
 CONFIG_SOC_IMX25=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_PM_DEBUG=y
+CONFIG_OPROFILE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.7.4
