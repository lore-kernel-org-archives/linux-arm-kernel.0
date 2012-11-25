From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 25 Nov 2012 18:53:40 +0400
Subject: [PATCH] ARM: Fix Kconfig symbols typo for LEDS
Message-ID: <1353855220-5238-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct option should be LEDS_TRIGGERS, not LEDS_TRIGGER.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-s3c24xx/Kconfig   |    2 +-
 arch/arm/plat-versatile/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index c0ef6b0..afd55c7 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -400,7 +400,7 @@ config MACH_MINI2440
 	bool "MINI2440 development board"
 	select EEPROM_AT24
 	select LEDS_CLASS
-	select LEDS_TRIGGER
+	select LEDS_TRIGGERS
 	select LEDS_TRIGGER_BACKLIGHT
 	select NEW_LEDS
 	select S3C_DEV_NAND
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 619f0fa..2c4332b 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -10,7 +10,7 @@ config PLAT_VERSATILE_LEDS
 	def_bool y if NEW_LEDS
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
 	select LEDS_CLASS
-	select LEDS_TRIGGER
+	select LEDS_TRIGGERS
 
 config PLAT_VERSATILE_SCHED_CLOCK
 	def_bool y
-- 
1.7.8.6
