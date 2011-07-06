From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:24 -0400
Subject: [PATCH 39/52] ARM: mach-s3c64xx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-39-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
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
index a53cf14..58d8cb5 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -233,7 +233,7 @@ static void __init anw6410_machine_init(void)
 
 MACHINE_START(ANW6410, "A&W6410")
 	/* Maintainer: Kwangwoo Lee <kwangwoo.lee@gmail.com> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= anw6410_map_io,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index b263958..c4d4d98 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -265,7 +265,7 @@ static void __init hmt_machine_init(void)
 
 MACHINE_START(HMT, "Airgoo-HMT")
 	/* Maintainer: Peter Korsgaard <jacmet@sunsite.dk> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 89f35e0..92b1f35 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -349,7 +349,7 @@ static void __init mini6410_machine_init(void)
 
 MACHINE_START(MINI6410, "MINI6410")
 	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index c498649..5c846be 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -97,7 +97,7 @@ static void __init ncp_machine_init(void)
 
 MACHINE_START(NCP, "NCP")
 	/* Maintainer: Samsung Electronics */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 4957ab0..0c62366 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -329,7 +329,7 @@ static void __init real6410_machine_init(void)
 
 MACHINE_START(REAL6410, "REAL6410")
 	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= real6410_map_io,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 3a3e5ac..22be187 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -146,7 +146,7 @@ static void __init smartq5_machine_init(void)
 
 MACHINE_START(SMARTQ5, "SmartQ 5")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e653758..5513f61 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -162,7 +162,7 @@ static void __init smartq7_machine_init(void)
 
 MACHINE_START(SMARTQ7, "SmartQ 7")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 3cca642..6fd5e95 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -85,7 +85,7 @@ static void __init smdk6400_machine_init(void)
 
 MACHINE_START(SMDK6400, "SMDK6400")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6400_init_irq,
 	.map_io		= smdk6400_map_io,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 2c0353a..b21f1b2 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -745,7 +745,7 @@ static void __init smdk6410_machine_init(void)
 
 MACHINE_START(SMDK6410, "SMDK6410")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smdk6410_map_io,
-- 
1.7.4
