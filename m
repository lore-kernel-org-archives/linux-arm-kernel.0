From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 31 Aug 2018 10:07:46 -0300
Subject: [PATCH 2/3] ARM: mxs_defconfig: Re-sync defconfig
In-Reply-To: <1535720867-4714-1-git-send-email-festevam@gmail.com>
References: <1535720867-4714-1-git-send-email-festevam@gmail.com>
Message-ID: <1535720867-4714-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Re-sync the defconfig by doing:
    
make savedefconfig
cp defconfig arch/arm/configs/mxs_defconfig

This helps making further mxs_defconfig changes to be cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/mxs_defconfig | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7b82128..3848059 100644
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
@@ -15,6 +16,9 @@ CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_MXS=y
+CONFIG_AEABI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
@@ -23,11 +27,6 @@ CONFIG_MODVERSIONS=y
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
@@ -80,7 +79,6 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_MXS_AUART=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MXS=y
@@ -102,7 +100,6 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
@@ -163,6 +160,10 @@ CONFIG_NLS_CODEPAGE_437=y
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
@@ -174,7 +175,3 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_DEV_MXS_DCP=y
-CONFIG_CRC_ITU_T=m
-CONFIG_CRC7=m
-CONFIG_FONTS=y
-- 
2.7.4
