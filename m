From: milo.kim@ti.com (Milo Kim)
Date: Mon, 29 Jun 2015 13:38:34 +0900
Subject: [PATCH] ARM: versatile: enable RTC DS1338 driver in defconfig
Message-ID: <1435552714-536-1-git-send-email-milo.kim@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Versatile platform boards[*] support external RTC device, DS1338.
It is compatible with rtc-ds1307 device driver.
This driver requires not only RTC subsystem configuration but also I2C host
bus support.

QEMU[**] also supports this device by default.

[*]  arch/arm/mach-versatile/core.c
[**] hw/arm/versatilepb.c

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Milo Kim <milo.kim@ti.com>
---
 arch/arm/configs/versatile_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index ea49d37..550500f 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -47,6 +47,7 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_VERSATILE=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
@@ -66,6 +67,9 @@ CONFIG_LEDS_VERSATILE=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
 CONFIG_VFAT_FS=m
 CONFIG_JFFS2_FS=y
-- 
1.9.1
