From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:22 -0400
Subject: [PATCH 37/52] ARM: mach-s3c24*: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-37-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-s3c2410/mach-amlm5900.c   |    2 +-
 arch/arm/mach-s3c2410/mach-bast.c       |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c      |    2 +-
 arch/arm/mach-s3c2410/mach-n30.c        |    4 ++--
 arch/arm/mach-s3c2410/mach-otom.c       |    2 +-
 arch/arm/mach-s3c2410/mach-qt2410.c     |    2 +-
 arch/arm/mach-s3c2410/mach-smdk2410.c   |    2 +-
 arch/arm/mach-s3c2410/mach-tct_hammer.c |    2 +-
 arch/arm/mach-s3c2410/mach-vr1000.c     |    2 +-
 arch/arm/mach-s3c2412/mach-jive.c       |    2 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c   |    6 +++---
 arch/arm/mach-s3c2412/mach-vstms.c      |    2 +-
 arch/arm/mach-s3c2416/mach-smdk2416.c   |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c     |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c  |    2 +-
 arch/arm/mach-s3c2440/mach-gta02.c      |    2 +-
 arch/arm/mach-s3c2440/mach-mini2440.c   |    2 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c   |    2 +-
 arch/arm/mach-s3c2440/mach-osiris.c     |    2 +-
 arch/arm/mach-s3c2440/mach-rx1950.c     |    2 +-
 arch/arm/mach-s3c2440/mach-rx3715.c     |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c   |    2 +-
 arch/arm/mach-s3c2443/mach-smdk2443.c   |    2 +-
 23 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index dabc141..7983894 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -236,7 +236,7 @@ static void __init amlm5900_init(void)
 }
 
 MACHINE_START(AML_M5900, "AML_M5900")
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= amlm5900_map_io,
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= amlm5900_init,
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 1e2d536..a20ae1a 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -657,7 +657,7 @@ static void __init bast_init(void)
 
 MACHINE_START(BAST, "Simtec-BAST")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= bast_map_io,
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= bast_init,
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 2a2fa06..556c535 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -744,7 +744,7 @@ static void __init h1940_init(void)
 
 MACHINE_START(H1940, "IPAQ-H1940")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= h1940_map_io,
 	.reserve	= h1940_reserve,
 	.init_irq	= h1940_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 079dcaa..1dc3e32 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -586,7 +586,7 @@ MACHINE_START(N30, "Acer-N30")
 	/* Maintainer: Christer Weinigel <christer@weinigel.se>,
 				Ben Dooks <ben-linux@fluff.org>
 	*/
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.timer		= &s3c24xx_timer,
 	.init_machine	= n30_init,
 	.init_irq	= s3c24xx_init_irq,
@@ -596,7 +596,7 @@ MACHINE_END
 MACHINE_START(N35, "Acer-N35")
 	/* Maintainer: Christer Weinigel <christer@weinigel.se>
 	*/
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.timer		= &s3c24xx_timer,
 	.init_machine	= n30_init,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c2410/mach-otom.c
index 0aa16cd..f03f3fd 100644
--- a/arch/arm/mach-s3c2410/mach-otom.c
+++ b/arch/arm/mach-s3c2410/mach-otom.c
@@ -116,7 +116,7 @@ static void __init otom11_init(void)
 
 MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	/* Maintainer: Guillaume GOURAT <guillaume.gourat@nexvision.tv> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= otom11_map_io,
 	.init_machine	= otom11_init,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index e8f49fe..33fd832 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -362,7 +362,7 @@ static void __init qt2410_machine_init(void)
 }
 
 MACHINE_START(QT2410, "QT2410")
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= qt2410_map_io,
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= qt2410_machine_init,
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
index e17f033..99c9dfd 100644
--- a/arch/arm/mach-s3c2410/mach-smdk2410.c
+++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
@@ -111,7 +111,7 @@ static void __init smdk2410_init(void)
 MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switch
 				    * to SMDK2410 */
 	/* Maintainer: Jonas Dietsche */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= smdk2410_map_io,
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= smdk2410_init,
diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c2410/mach-tct_hammer.c
index 43c2b83..e0d0b6f 100644
--- a/arch/arm/mach-s3c2410/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c2410/mach-tct_hammer.c
@@ -146,7 +146,7 @@ static void __init tct_hammer_init(void)
 }
 
 MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= tct_hammer_map_io,
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= tct_hammer_init,
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
index 6ccce5a..df47e8e 100644
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -400,7 +400,7 @@ static void __init vr1000_init(void)
 
 MACHINE_START(VR1000, "Thorcom-VR1000")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= vr1000_map_io,
 	.init_machine	= vr1000_init,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 85dcaeb..6a143ea 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -668,7 +668,7 @@ static void __init jive_machine_init(void)
 
 MACHINE_START(JIVE, "JIVE")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
 	.map_io		= jive_map_io,
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index 834cfb6..d6325ed 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -128,7 +128,7 @@ static void __init smdk2413_machine_init(void)
 
 MACHINE_START(S3C2413, "S3C2413")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.fixup		= smdk2413_fixup,
 	.init_irq	= s3c24xx_init_irq,
@@ -139,7 +139,7 @@ MACHINE_END
 
 MACHINE_START(SMDK2412, "SMDK2412")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.fixup		= smdk2413_fixup,
 	.init_irq	= s3c24xx_init_irq,
@@ -150,7 +150,7 @@ MACHINE_END
 
 MACHINE_START(SMDK2413, "SMDK2413")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.fixup		= smdk2413_fixup,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
index 83544eb..5955c15 100644
--- a/arch/arm/mach-s3c2412/mach-vstms.c
+++ b/arch/arm/mach-s3c2412/mach-vstms.c
@@ -156,7 +156,7 @@ static void __init vstms_init(void)
 }
 
 MACHINE_START(VSTMS, "VSTMS")
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.fixup		= vstms_fixup,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index ac27ebb..a9eee53 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -245,7 +245,7 @@ static void __init smdk2416_machine_init(void)
 
 MACHINE_START(SMDK2416, "SMDK2416")
 	/* Maintainer: Yauhen Kharuzhy <jekhor@gmail.com> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
 	.map_io		= smdk2416_map_io,
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index d708678..74f92fc 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -498,7 +498,7 @@ static void __init anubis_init(void)
 
 MACHINE_START(ANUBIS, "Simtec-Anubis")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= anubis_map_io,
 	.init_machine	= anubis_init,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 6c98b78..38887ee 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -233,7 +233,7 @@ static void __init at2440evb_init(void)
 
 
 MACHINE_START(AT2440EVB, "AT2440EVB")
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= at2440evb_map_io,
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 7166620..d085f48 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -596,7 +596,7 @@ static void __init gta02_machine_init(void)
 
 MACHINE_START(NEO1973_GTA02, "GTA02")
 	/* Maintainer: Nelson Castillo <arhuaco@freaks-unidos.net> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= gta02_map_io,
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= gta02_machine_init,
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index dd3120d..9e4251f 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -676,7 +676,7 @@ static void __init mini2440_init(void)
 
 MACHINE_START(MINI2440, "MINI2440")
 	/* Maintainer: Michel Pollet <buserror@gmail.com> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= mini2440_map_io,
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 37dd306..61c0bf1 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -151,7 +151,7 @@ static void __init nexcoder_init(void)
 
 MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	/* Maintainer: Guillaume GOURAT <guillaume.gourat@nexvision.tv> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= nexcoder_map_io,
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index d885363..dc142eb 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -447,7 +447,7 @@ static void __init osiris_init(void)
 
 MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	/* Maintainer: Ben Dooks <ben@simtec.co.uk> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= osiris_map_io,
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= osiris_init,
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 27ea950..684dbb3 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -825,7 +825,7 @@ static void __init rx1950_reserve(void)
 
 MACHINE_START(RX1950, "HP iPAQ RX1950")
     /* Maintainers: Vasily Khoruzhick */
-	.boot_params = S3C2410_SDRAM_PA + 0x100,
+	.atag_offset = 0x100,
 	.map_io = rx1950_map_io,
 	.reserve	= rx1950_reserve,
 	.init_irq = s3c24xx_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 1472b1a..e19499c 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -218,7 +218,7 @@ static void __init rx3715_init_machine(void)
 
 MACHINE_START(RX3715, "IPAQ-RX3715")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= rx3715_map_io,
 	.reserve	= rx3715_reserve,
 	.init_irq	= rx3715_init_irq,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index eedfe0f..36eeb41 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -175,7 +175,7 @@ static void __init smdk2440_machine_init(void)
 
 MACHINE_START(S3C2440, "SMDK2440")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
 	.map_io		= smdk2440_map_io,
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index 514275e..bec107e0 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -139,7 +139,7 @@ static void __init smdk2443_machine_init(void)
 
 MACHINE_START(SMDK2443, "SMDK2443")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
-	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s3c24xx_init_irq,
 	.map_io		= smdk2443_map_io,
-- 
1.7.4
