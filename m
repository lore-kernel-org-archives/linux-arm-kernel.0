From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:12 +0100
Subject: [PATCH 2/9] ARM: SAMSUNG: Remove s3c_i2c1_setname() calls for
	s3c2440-i2c
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we've defaulted the s3c_device_i2c1's name to s3c2440-i2c, remove
all the s3c_i2c1_setname("s3c2440-i2c") as they are no longer needed.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2416/s3c2416.c |    1 -
 arch/arm/mach-s3c64xx/s3c6410.c |    1 -
 arch/arm/mach-s5pc100/cpu.c     |    1 -
 arch/arm/mach-s5pv210/cpu.c     |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 35dabcc..4213f79 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -88,7 +88,6 @@ int __init s3c2416_init(void)
 
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c1_setname("s3c2440-i2c");
 
 	s3c_device_fb.name = "s3c2443-fb";
 
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 014401c..b5fc100 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -52,7 +52,6 @@ void __init s3c6410_map_io(void)
 
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c1_setname("s3c2440-i2c");
 
 	s3c_device_adc.name	= "s3c64xx-adc";
 	s3c_device_nand.name = "s3c6400-nand";
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index 7b5bdbc..f020aeb 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -89,7 +89,6 @@ void __init s5pc100_map_io(void)
 
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c1_setname("s3c2440-i2c");
 
 	s3c_onenand_setname("s5pc100-onenand");
 }
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 411a4a9..987fe1d 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -89,7 +89,6 @@ void __init s5pv210_map_io(void)
 
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c1_setname("s3c2440-i2c");
 	s3c_i2c2_setname("s3c2440-i2c");
 }
 
-- 
1.6.3.3
