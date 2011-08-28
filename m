From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Aug 2011 02:49:07 +0200
Subject: [PATCH 4/5] ARM: s3c64xx: Move all machines to s3c64xx_timer.
Message-ID: <mailman.113.1314794150.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes all machines based on S3C64xx to use the new s3c64xx_timer
macro instead of old s3c24xx_timer, to allow switching of timer implementation
by Kconfig option.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-anw6410.c  |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c      |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c      |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c  |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c  |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index a53cf14..eb6c5d7 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -238,5 +238,5 @@ MACHINE_START(ANW6410, "A&W6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index b263958..448c1ca 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -269,5 +269,5 @@ MACHINE_START(HMT, "Airgoo-HMT")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 89f35e0..6a19466 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -353,5 +353,5 @@ MACHINE_START(MINI6410, "MINI6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index c498649..218295e 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -101,5 +101,5 @@ MACHINE_START(NCP, "NCP")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 4957ab0..6584953 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -334,5 +334,5 @@ MACHINE_START(REAL6410, "REAL6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 3a3e5ac..0af2261 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -150,5 +150,5 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e653758..c5f3d05 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -166,5 +166,5 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 3cca642..252c931 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -90,5 +90,5 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.init_irq	= s3c6400_init_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 2c0353a..f902a9b 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -750,5 +750,5 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s3c64xx_timer,
 MACHINE_END
-- 
1.7.6.1
