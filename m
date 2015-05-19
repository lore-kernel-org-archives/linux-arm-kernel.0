From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 May 2015 11:04:28 +0200
Subject: [PATCH] ARM: at91/defconfig: add CONFIG_REGULATOR_FIXED_VOLTAGE for
 mmc driver
Message-ID: <1432026268-14007-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As an update of the sd/mmc DT definition needs the fixed voltage regulator, add
it to the at91 defconfigs.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/at91_dt_defconfig | 2 ++
 arch/arm/configs/sama5_defconfig   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index bcef49a21801..94b5dcabdecc 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -131,6 +131,8 @@ CONFIG_POWER_RESET=y
 CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SSB=m
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_FB=y
 CONFIG_FB_ATMEL=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 510c747c65b4..31eb951880ae 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -136,6 +136,7 @@ CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
 CONFIG_SSB=m
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ACT8865=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
-- 
2.1.3
