From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:15 +0100
Subject: [PATCH 5/9] ARM: SAMSUNG: Eliminate s3c2440-i2c renames
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0445af6624016110d1b448e0089261548ba29ee3 set the default
name to s3c2440-i2c, so we no longer need to do anything about
renaming it. Remove all the call sites and the header that was
included to get it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2412/s3c2412.c |    2 +-
 arch/arm/mach-s3c2416/s3c2416.c |    5 -----
 arch/arm/mach-s3c64xx/s3c6400.c |    4 ----
 arch/arm/mach-s3c64xx/s3c6410.c |    4 ----
 arch/arm/mach-s5pc100/cpu.c     |    4 ----
 arch/arm/mach-s5pv210/cpu.c     |    4 ----
 6 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-s3c2412/s3c2412.c
index d16d72b..5a76774 100644
--- a/arch/arm/mach-s3c2412/s3c2412.c
+++ b/arch/arm/mach-s3c2412/s3c2412.c
@@ -46,9 +46,9 @@
 #include <mach/regs-s3c2412.h>
 
 #include <plat/s3c2412.h>
-#include <plat/iic-core.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/iic-core.h>
 #include <plat/clock.h>
 #include <plat/pm.h>
 #include <plat/pll.h>
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 4213f79..6e41cf5 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -54,8 +54,6 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include <plat/iic-core.h>
-
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
@@ -86,9 +84,6 @@ int __init s3c2416_init(void)
 	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
 	s3c_device_wdt.resource[1].end   = IRQ_S3C2443_WDT;
 
-	/* the i2c devices are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
-
 	s3c_device_fb.name = "s3c2443-fb";
 
 	return sysdev_register(&s3c2416_sysdev);
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 5e93fe3..9e056b4 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -36,7 +36,6 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/sdhci.h>
-#include <plat/iic-core.h>
 #include <plat/onenand-core.h>
 #include <mach/s3c6400.h>
 
@@ -48,9 +47,6 @@ void __init s3c6400_map_io(void)
 	s3c6400_default_sdhci1();
 	s3c6400_default_sdhci2();
 
-	/* the i2c devices are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
-
 	s3c_device_nand.name = "s3c6400-nand";
 
 	s3c_onenand_setname("s3c6400-onenand");
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index b5fc100..2afba13 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -37,7 +37,6 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/sdhci.h>
-#include <plat/iic-core.h>
 #include <plat/adc.h>
 #include <plat/onenand-core.h>
 #include <mach/s3c6400.h>
@@ -50,9 +49,6 @@ void __init s3c6410_map_io(void)
 	s3c6410_default_sdhci1();
 	s3c6410_default_sdhci2();
 
-	/* the i2c devices are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
-
 	s3c_device_adc.name	= "s3c64xx-adc";
 	s3c_device_nand.name = "s3c6400-nand";
 	s3c_onenand_setname("s3c6410-onenand");
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index f020aeb..521a677 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -38,7 +38,6 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
-#include <plat/iic-core.h>
 #include <plat/sdhci.h>
 #include <plat/onenand-core.h>
 
@@ -87,9 +86,6 @@ void __init s5pc100_map_io(void)
 	s5pc100_default_sdhci1();
 	s5pc100_default_sdhci2();
 
-	/* the i2c devices are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
-
 	s3c_onenand_setname("s5pc100-onenand");
 }
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 8a64ef3..b14b64d 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -32,7 +32,6 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
-#include <plat/iic-core.h>
 #include <plat/sdhci.h>
 
 /* Initial IO mappings */
@@ -86,9 +85,6 @@ void __init s5pv210_map_io(void)
 	s5pv210_default_sdhci0();
 	s5pv210_default_sdhci1();
 	s5pv210_default_sdhci2();
-
-	/* the i2c devices are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
 }
 
 void __init s5pv210_init_clocks(int xtal)
-- 
1.6.3.3
