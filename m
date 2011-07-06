From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:49 -0400
Subject: [PATCH 04/52] ARM: mach-davinci: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-davinci/board-da830-evm.c     |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |    4 ++--
 arch/arm/mach-davinci/board-mityomapl138.c  |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 84fd7868..26d94c0 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -676,7 +676,7 @@ static void __init da830_evm_map_io(void)
 }
 
 MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
-	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.atag_offset	= 0x100,
 	.map_io		= da830_evm_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 29671ef..bcbe439 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1256,7 +1256,7 @@ static void __init da850_evm_map_io(void)
 }
 
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
-	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.atag_offset	= 0x100,
 	.map_io		= da850_evm_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 241a6bd..6556628 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -351,7 +351,7 @@ static __init void dm355_evm_init(void)
 }
 
 MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
-	.boot_params  = (0x80000100),
+	.atag_offset  = 0x100,
 	.map_io	      = dm355_evm_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index bee284c..b307470 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -270,7 +270,7 @@ static __init void dm355_leopard_init(void)
 }
 
 MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
-	.boot_params  = (0x80000100),
+	.atag_offset  = 0x100,
 	.map_io	      = dm355_leopard_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 9844fa4..00ed6fb 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -612,7 +612,7 @@ static __init void dm365_evm_init(void)
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-	.boot_params	= (0x80000100),
+	.atag_offset	= 0x100,
 	.map_io		= dm365_evm_map_io,
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 95607a1..a005e769 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -712,7 +712,7 @@ static __init void davinci_evm_init(void)
 
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	/* Maintainer: MontaVista Software <source@mvista.com> */
-	.boot_params  = (DAVINCI_DDR_BASE + 0x100),
+	.atag_offset  = 0x100,
 	.map_io	      = davinci_evm_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 6d03643..c594518 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -797,7 +797,7 @@ void __init dm646x_board_setup_refclk(struct clk *clk)
 }
 
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
-	.boot_params  = (0x80000100),
+	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer        = &davinci_timer,
@@ -806,7 +806,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 MACHINE_END
 
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
-	.boot_params  = (0x80000100),
+	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer        = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index b8d59ca..fac14c1 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -565,7 +565,7 @@ static void __init mityomapl138_map_io(void)
 }
 
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
-	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.atag_offset	= 0x100,
 	.map_io		= mityomapl138_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index d60a800..38d6f64 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -272,7 +272,7 @@ static __init void davinci_ntosd2_init(void)
 
 MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	/* Maintainer: Neuros Technologies <neuros@groups.google.com> */
-	.boot_params	= (DAVINCI_DDR_BASE + 0x100),
+	.atag_offset	= 0x100,
 	.map_io		 = davinci_ntosd2_map_io,
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 237332a..c6701e4 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -338,7 +338,7 @@ static void __init omapl138_hawk_map_io(void)
 }
 
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
-	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.atag_offset	= 0x100,
 	.map_io		= omapl138_hawk_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 5f4385c..5dd4da9 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -151,7 +151,7 @@ static __init void davinci_sffsdr_init(void)
 
 MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	/* Maintainer: Hugo Villeneuve hugo.villeneuve at lyrtech.com */
-	.boot_params  = (DAVINCI_DDR_BASE + 0x100),
+	.atag_offset  = 0x100,
 	.map_io	      = davinci_sffsdr_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 7828920..90ee7b5 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -277,7 +277,7 @@ console_initcall(tnetv107x_evm_console_init);
 #endif
 
 MACHINE_START(TNETV107X, "TNETV107X EVM")
-	.boot_params	= (TNETV107X_DDR_BASE + 0x100),
+	.atag_offset	= 0x100,
 	.map_io		= tnetv107x_init,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
-- 
1.7.4
