From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:15 -0400
Subject: [PATCH 30/52] ARM: mach-omap1: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-30-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c |    2 +-
 arch/arm/mach-omap1/board-fsample.c   |    2 +-
 arch/arm/mach-omap1/board-generic.c   |    2 +-
 arch/arm/mach-omap1/board-h2.c        |    2 +-
 arch/arm/mach-omap1/board-h3.c        |    2 +-
 arch/arm/mach-omap1/board-htcherald.c |    2 +-
 arch/arm/mach-omap1/board-innovator.c |    2 +-
 arch/arm/mach-omap1/board-nokia770.c  |    2 +-
 arch/arm/mach-omap1/board-osk.c       |    2 +-
 arch/arm/mach-omap1/board-palmte.c    |    2 +-
 arch/arm/mach-omap1/board-palmtt.c    |    2 +-
 arch/arm/mach-omap1/board-palmz71.c   |    2 +-
 arch/arm/mach-omap1/board-perseus2.c  |    2 +-
 arch/arm/mach-omap1/board-sx1.c       |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c |    2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index de88c92..e501586 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -386,7 +386,7 @@ static void __init ams_delta_map_io(void)
 
 MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	/* Maintainer: Jonathan McDowell <noodles@earth.li> */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= ams_delta_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= ams_delta_init_irq,
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 87f173d..944709b 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -389,7 +389,7 @@ static void __init omap_fsample_map_io(void)
 
 MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 /* Maintainer: Brian Swetland <swetland@google.com> */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_fsample_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_fsample_init_irq,
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 23f4ab9..eeb89f1 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -94,7 +94,7 @@ static void __init omap_generic_map_io(void)
 
 MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	/* Maintainer: Tony Lindgren <tony@atomide.com> */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_generic_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_generic_init_irq,
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index ba3bd09..90e41e8 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -461,7 +461,7 @@ static void __init h2_map_io(void)
 
 MACHINE_START(OMAP_H2, "TI-H2")
 	/* Maintainer: Imre Deak <imre.deak@nokia.com> */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= h2_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= h2_init_irq,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index ac48677..685d91d 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -449,7 +449,7 @@ static void __init h3_map_io(void)
 
 MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	/* Maintainer: Texas Instruments, Inc. */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= h3_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= h3_init_irq,
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index ba05a51..7d923ba 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -611,7 +611,7 @@ static void __init htcherald_init_irq(void)
 MACHINE_START(HERALD, "HTC Herald")
 	/* Maintainer: Cory Maccarrone <darkstar6262@gmail.com> */
 	/* Maintainer: wing-linux.sourceforge.net */
-	.boot_params    = 0x10000100,
+	.atag_offset    = 0x100,
 	.map_io         = htcherald_map_io,
 	.reserve	= omap_reserve,
 	.init_irq       = htcherald_init_irq,
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2d9b8cb..3d505f3 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -459,7 +459,7 @@ static void __init innovator_map_io(void)
 
 MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	/* Maintainer: MontaVista Software, Inc. */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= innovator_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= innovator_init_irq,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index cfd0849..abcddd8 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -264,7 +264,7 @@ static void __init omap_nokia770_map_io(void)
 }
 
 MACHINE_START(NOKIA770, "Nokia 770")
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_nokia770_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_nokia770_init_irq,
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index e68dfde..319ff26 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -583,7 +583,7 @@ static void __init osk_map_io(void)
 
 MACHINE_START(OMAP_OSK, "TI-OSK")
 	/* Maintainer: Dirk Behme <dirk.behme@de.bosch.com> */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= osk_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= osk_init_irq,
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index c9d38f4..73beff9 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -275,7 +275,7 @@ static void __init omap_palmte_map_io(void)
 }
 
 MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_palmte_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_palmte_init_irq,
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index f04f2d3..424cec1 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -321,7 +321,7 @@ static void __init omap_palmtt_map_io(void)
 }
 
 MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_palmtt_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_palmtt_init_irq,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 45f01d2..cfa8ea7 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -341,7 +341,7 @@ omap_palmz71_map_io(void)
 }
 
 MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_palmz71_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_palmz71_init_irq,
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 3c8ee84..d4ec492 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -350,7 +350,7 @@ static void __init omap_perseus2_map_io(void)
 
 MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	/* Maintainer: Kevin Hilman <kjh@hilman.org> */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_perseus2_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_perseus2_init_irq,
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 0ad781d..c7f829b 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -421,7 +421,7 @@ static void __init omap_sx1_map_io(void)
 }
 
 MACHINE_START(SX1, "OMAP310 based Siemens SX1")
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap_sx1_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= omap_sx1_init_irq,
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 65d2420..a1def14 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -301,7 +301,7 @@ static void __init voiceblue_init(void)
 
 MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	/* Maintainer: Ladislav Michl <michl@2n.cz> */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.map_io		= voiceblue_map_io,
 	.reserve	= omap_reserve,
 	.init_irq	= voiceblue_init_irq,
-- 
1.7.4
