From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 11 Nov 2011 00:21:25 +0100
Subject: [PATCH] ARM: mach-s3c2440: drop selects of bogus Kconfig symbols
Message-ID: <1320967285.27598.91.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no Kconfig symbols named MACH_NEO1973 and S3C2410_PWM. The
three select statements for these symbols are nops. Drop these.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested by running "make ARCH=arm menuconfig" for both machines (with
defaults from some x86 config file, as there are no defconfigs for these
machines). Nothing related to these Kconfig symbols showed up in the
generated config files. From that it follows that dropping these select
statements changes nothing.

 arch/arm/mach-s3c2440/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index e505701..70a12b3 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -93,8 +93,6 @@ config MACH_NEO1973_GTA02
 	select PCF50633_GPIO
 	select I2C
 	select POWER_SUPPLY
-	select MACH_NEO1973
-	select S3C2410_PWM
 	select S3C_DEV_USB_HOST
 	help
 	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
@@ -192,7 +190,6 @@ config MACH_RX1950
 	select S3C24XX_DCLK
 	select PM_H1940 if PM
 	select I2C
-	select S3C2410_PWM
 	select S3C_DEV_NAND
 	select S3C2410_IOTIMING if S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
-- 
1.7.4.4
