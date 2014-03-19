From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:42 +0100
Subject: [PATCH 45/62] ARM: s3c24xx: MINI2440 needs I2C for EEPROM_AT24
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-46-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If I2C is disabled, we cannot build the AT24 driver, so we
should not select it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c24xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index bb1fa603..a6060d0 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -536,7 +536,7 @@ config MACH_AT2440EVB
 
 config MACH_MINI2440
 	bool "MINI2440 development board"
-	select EEPROM_AT24
+	select EEPROM_AT24 if I2C
 	select LEDS_CLASS
 	select LEDS_TRIGGERS
 	select LEDS_TRIGGER_BACKLIGHT
-- 
1.8.3.2
