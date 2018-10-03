From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Oct 2018 11:13:50 -0300
Subject: [PATCH v2 3/6] ARM: mxs_defconfig: Re-sync defconfig
In-Reply-To: <1538576033-23415-1-git-send-email-festevam@gmail.com>
References: <1538576033-23415-1-git-send-email-festevam@gmail.com>
Message-ID: <1538576033-23415-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-sync the defconfig by doing:
    
make savedefconfig
cp defconfig arch/arm/configs/mxs_defconfig

and only keep the options that were moved around.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Only show the options that were moved around

 arch/arm/configs/mxs_defconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7b82128..2119a6a 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -1,6 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
@@ -15,6 +16,10 @@ CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_MXS=y
+# CONFIG_ARM_THUMB is not set
+CONFIG_AEABI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
@@ -23,11 +28,6 @@ CONFIG_MODVERSIONS=y
 CONFIG_BLK_DEV_INTEGRITY=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-# CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_ARCH_MXS=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_AEABI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -163,6 +163,10 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
+CONFIG_CRYPTO_DEV_MXS_DCP=y
+CONFIG_CRC_ITU_T=m
+CONFIG_CRC7=m
+CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_WARN=2048
@@ -174,7 +178,3 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_DEV_MXS_DCP=y
-CONFIG_CRC_ITU_T=m
-CONFIG_CRC7=m
-CONFIG_FONTS=y
-- 
2.7.4
