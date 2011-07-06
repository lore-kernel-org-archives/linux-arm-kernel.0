From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:16 -0400
Subject: [PATCH 31/52] ARM: mach-omap2: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-31-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c        |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c    |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
 arch/arm/mach-omap2/board-apollon.c        |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c       |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c        |    2 +-
 arch/arm/mach-omap2/board-h4.c             |    2 +-
 arch/arm/mach-omap2/board-igep0020.c       |    4 ++--
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/board-n8x0.c           |    6 +++---
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c     |    4 ++--
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/board-rm680.c          |    2 +-
 arch/arm/mach-omap2/board-rx51.c           |    2 +-
 arch/arm/mach-omap2/board-ti8168evm.c      |    2 +-
 arch/arm/mach-omap2/board-zoom.c           |    4 ++--
 27 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 5de6eac..0ffe335 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -256,7 +256,7 @@ static void __init omap_2430sdp_map_io(void)
 
 MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_2430sdp_map_io,
 	.init_early	= omap_2430sdp_init_early,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5dac974..a4c89e1 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -800,7 +800,7 @@ static void __init omap_3430sdp_init(void)
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_3430sdp_init_early,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index a5933cc..f3c1c68 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -215,7 +215,7 @@ static void __init omap_sdp_init(void)
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_sdp_init_early,
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..b949cc0 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -767,7 +767,7 @@ static void __init omap_4430sdp_map_io(void)
 
 MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_4430sdp_map_io,
 	.init_early	= omap_4430sdp_init_early,
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 5e438a7..d24ad37 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -100,7 +100,7 @@ static void __init am3517_crane_init(void)
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= am3517_crane_init_early,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 63af417..743dbd9 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -490,7 +490,7 @@ static void __init am3517_evm_init(void)
 }
 
 MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= am3517_evm_init_early,
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index b124bdf..afd7b4f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -350,7 +350,7 @@ static void __init omap_apollon_map_io(void)
 
 MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_apollon_map_io,
 	.init_early	= omap_apollon_init_early,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 77456de..9909786 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -642,7 +642,7 @@ static void __init cm_t35_init(void)
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= cm_t35_init_early,
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index c3a9fd3..783a46c 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -300,7 +300,7 @@ static void __init cm_t3517_init(void)
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve        = omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= cm_t3517_init_early,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 34956ec..660ab39 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -701,7 +701,7 @@ static void __init devkit8000_init(void)
 }
 
 MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= devkit8000_init_early,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 73e3c31..1e42820 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -66,7 +66,7 @@ static void __init omap_generic_map_io(void)
 /* XXX This machine entry name should be updated */
 MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_generic_map_io,
 	.init_early	= omap_generic_init_early,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index bac7933..2f5b94e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -382,7 +382,7 @@ static void __init omap_h4_map_io(void)
 
 MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap_h4_map_io,
 	.init_early	= omap_h4_init_early,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0c1bfca..dbdd203 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -699,7 +699,7 @@ static void __init igep_init(void)
 }
 
 MACHINE_START(IGEP0020, "IGEP v2 board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= igep_init_early,
@@ -709,7 +709,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 MACHINE_END
 
 MACHINE_START(IGEP0030, "IGEP OMAP3 module")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= igep_init_early,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f7d6038..62c65fe 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -346,7 +346,7 @@ static void __init omap_ldp_init(void)
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_ldp_init_early,
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 8d74318..43bb006 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -695,7 +695,7 @@ static void __init n8x0_init_machine(void)
 }
 
 MACHINE_START(NOKIA_N800, "Nokia N800")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
 	.init_early	= n8x0_init_early,
@@ -705,7 +705,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 MACHINE_END
 
 MACHINE_START(NOKIA_N810, "Nokia N810")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
 	.init_early	= n8x0_init_early,
@@ -715,7 +715,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 MACHINE_END
 
 MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= n8x0_map_io,
 	.init_early	= n8x0_init_early,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7f21d24..b0da303 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -593,7 +593,7 @@ static void __init omap3_beagle_init(void)
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_beagle_init_early,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b4d4346..2f62db1 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -736,7 +736,7 @@ static void __init omap3_evm_init(void)
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	/* Maintainer: Syed Mohammed Khasim - Texas Instruments */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_evm_init_early,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 60d9be4..95f728f 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -212,7 +212,7 @@ static void __init omap3logic_init(void)
 }
 
 MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3logic_init_early,
 	.init_irq	= omap_init_irq,
@@ -221,7 +221,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 MACHINE_END
 
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3logic_init_early,
 	.init_irq	= omap_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 23f71d4..c072141 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -639,7 +639,7 @@ static void __init omap3pandora_init(void)
 }
 
 MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3pandora_init_early,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 0c108a2..b8fc04d 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -555,7 +555,7 @@ static void __init omap3_stalker_init(void)
 
 MACHINE_START(SBC3530, "OMAP3 STALKER")
 	/* Maintainer: Jason Lam -lzg at ema-tech.com */
-	.boot_params		= 0x80000100,
+	.atag_offset		= 0x100,
 	.map_io			= omap3_map_io,
 	.init_early		= omap3_stalker_init_early,
 	.init_irq		= omap3_stalker_init_irq,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 5f649fa..324ada5 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -443,7 +443,7 @@ static void __init omap3_touchbook_init(void)
 
 MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	/* Maintainer: Gregoire Gentil - http://www.alwaysinnovating.com */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_touchbook_init_early,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 0cfe200..2a37784 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -710,7 +710,7 @@ static void __init omap4_panda_map_io(void)
 
 MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap4_panda_map_io,
 	.init_early	= omap4_panda_init_early,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 175e1ab..7fae10f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -611,7 +611,7 @@ static void __init overo_init(void)
 }
 
 MACHINE_START(OVERO, "Gumstix Overo")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= overo_init_early,
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 42d10b1..b5b78b6 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -159,7 +159,7 @@ static void __init rm680_map_io(void)
 }
 
 MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= rm680_map_io,
 	.init_early	= rm680_init_early,
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index fec4cac..897f17f 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -156,7 +156,7 @@ static void __init rx51_reserve(void)
 
 MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= rx51_reserve,
 	.map_io		= rx51_map_io,
 	.init_early	= rx51_init_early,
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 09fa7bf..76847cb 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -53,7 +53,7 @@ static void __init ti8168_evm_map_io(void)
 
 MACHINE_START(TI8168EVM, "ti8168evm")
 	/* Maintainer: Texas Instruments */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.map_io		= ti8168_evm_map_io,
 	.init_early	= ti8168_init_early,
 	.init_irq	= ti8168_evm_init_irq,
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 4b133d7..3e35ab6 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -133,7 +133,7 @@ static void __init omap_zoom_init(void)
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_zoom_init_early,
@@ -143,7 +143,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 MACHINE_END
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_zoom_init_early,
-- 
1.7.4
