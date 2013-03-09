From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 09 Mar 2013 20:08:01 +0100
Subject: [PATCH] ARM: S3C24XX: drop "select MACH_NEO1973"
Message-ID: <1362856081.3137.19.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig entry for the Openmoko GTA02 / Freerunner phone selects
MACH_NEO1973. But there is no Kconfig symbol MACH_NEO1973. The select
statement for that symbol is a nop. It can safely be dropped.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested with "git grep".

1) There appear to be repositories that carry a "config MACH_NEO1973" in
their tree. I guess it is used to collect functionality common to the
GTA01 and the GTA02. But except for this select statement, MACH_NEO1973
was never used in mainline. So if the GTA01 code ever gets merged into
mainline, this select statement might be added once more (if it is
actually needed then).

 arch/arm/mach-s3c24xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 7361b9d..bec43fe 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -641,7 +641,6 @@ comment "S3C2442 Boards"
 config MACH_NEO1973_GTA02
 	bool "Openmoko GTA02 / Freerunner phone"
 	select I2C
-	select MACH_NEO1973
 	select MFD_PCF50633
 	select PCF50633_GPIO
 	select POWER_SUPPLY
-- 
1.7.11.7
