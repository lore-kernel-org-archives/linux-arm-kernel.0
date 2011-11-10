From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 10 Nov 2011 23:10:14 +0100
Subject: [PATCH] ARM: mini2440: Fix Kconfig select of LEDS_TRIGGER
Message-ID: <1320963014.27598.77.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2e18edf75d ("ARM: mini2440: Fix Kconfig to allow kernel to
build") added "select LEDS_TRIGGER" to the MACH_MINI2440 entry. That
Kconfig symbol doesn't exist. What actually should be selected is
LEDS_TRIGGERS.

(This shouldn't be a problem with the mini2440 defconfig, since it
contains "CONFIG_MAC80211_LEDS=y" and MAC80211_LEDS selects
LEDS_TRIGGERS. But it seems that nothing mini2440 related pulls in
MAC80211_LEDS.)

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "yes "" | make ARCH=arm config", using the
mini2440_defconfig with the CONFIG_MAC80211_LEDS=y line commented out.

 arch/arm/mach-s3c2440/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index 914e620..e505701 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -178,7 +178,7 @@ config MACH_MINI2440
 	select EEPROM_AT24
 	select NEW_LEDS
 	select LEDS_CLASS
-	select LEDS_TRIGGER
+	select LEDS_TRIGGERS
 	select LEDS_TRIGGER_BACKLIGHT
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
-- 
1.7.4.4
