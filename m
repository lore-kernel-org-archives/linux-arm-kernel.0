From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 14 May 2017 15:13:50 +0000
Subject: [PATCH 2/2] ARM: mxs_defconfig: Re-enable MXS LRADC
In-Reply-To: <1494774830-2823-1-git-send-email-stefan.wahren@i2se.com>
References: <1494774830-2823-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1494774830-2823-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MXS LRADC driver left staging and has been split. So re-enable
the driver and remove the obsolete entries.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/mxs_defconfig |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7b36ebb..aef2b54 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -76,6 +76,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_MXS_LRADC=y
 CONFIG_TOUCHSCREEN_TSC2007=m
 # CONFIG_SERIO is not set
 CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
@@ -96,6 +97,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_STMP3XXX_RTC_WATCHDOG=y
+CONFIG_MFD_MXS_LRADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_FB=y
@@ -137,10 +139,9 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_STMP=y
 CONFIG_DMADEVICES=y
 CONFIG_MXS_DMA=y
-CONFIG_STAGING=y
-CONFIG_MXS_LRADC=y
 CONFIG_IIO=y
 CONFIG_IIO_SYSFS_TRIGGER=y
+CONFIG_MXS_LRADC_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_MXS=y
 CONFIG_NVMEM=y
-- 
1.7.9.5
