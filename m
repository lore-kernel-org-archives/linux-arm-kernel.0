From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:27 +0800
Subject: [PATCH 02/15] ARM: davinci: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-davinci/board-da830-evm.c     |    1 +
 arch/arm/mach-davinci/board-da850-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm355-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm355-leopard.c |    1 +
 arch/arm/mach-davinci/board-dm365-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |    1 +
 arch/arm/mach-davinci/board-dm646x-evm.c    |    1 +
 arch/arm/mach-davinci/board-mityomapl138.c  |    1 +
 arch/arm/mach-davinci/board-neuros-osd2.c   |    1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c |    1 +
 arch/arm/mach-davinci/board-sffsdr.c        |    1 +
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    1 +
 arch/arm/mach-davinci/clock.c               |    3 +--
 arch/arm/mach-davinci/common.c              |    7 +++++++
 arch/arm/mach-davinci/cpufreq.c             |    3 +--
 arch/arm/mach-davinci/include/mach/common.h |   19 +++++++++++++++++++
 arch/arm/mach-davinci/pm.c                  |    3 +--
 17 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index dc1afe5..0031864 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -681,6 +681,7 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= da830_evm_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a70de24..280cbed 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1411,6 +1411,7 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= da850_evm_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 82ed753..1c7b1f4 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -357,6 +357,7 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = dm355_evm_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index d74a8b3..8e77032 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -276,6 +276,7 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = dm355_leopard_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 5bce2b8..688a9c5 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -618,6 +618,7 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
 	.init_machine	= dm365_evm_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 3683306..d34ed55 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -825,6 +825,7 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = davinci_evm_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index d72ab94..f213359 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -798,6 +798,7 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.init_irq     = davinci_irq_init,
 	.timer        = &davinci_timer,
 	.init_machine = evm_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 672d820..beecde3 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -572,6 +572,7 @@ MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= mityomapl138_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index a772bb4..5de69f2 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -278,6 +278,7 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
 	.init_machine = davinci_ntosd2_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 45e8157..dc1208e 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -343,6 +343,7 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= omapl138_hawk_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 76e67509..9078acf 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -157,6 +157,7 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
 	.init_machine = davinci_sffsdr_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 5f14e30..ac4e003 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -282,6 +282,7 @@ MACHINE_START(TNETV107X, "TNETV107X EVM")
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
 	.init_machine	= tnetv107x_evm_board_init,
+	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 	.restart	= tnetv107x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 008772e..34668ea 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -213,7 +213,7 @@ EXPORT_SYMBOL(clk_unregister);
 /*
  * Disable any unused clocks left on by the bootloader
  */
-static int __init clk_disable_unused(void)
+int __init davinci_clk_disable_unused(void)
 {
 	struct clk *ck;
 
@@ -237,7 +237,6 @@ static int __init clk_disable_unused(void)
 
 	return 0;
 }
-late_initcall(clk_disable_unused);
 #endif
 
 static unsigned long clk_sysclk_recalc(struct clk *clk)
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index cb9b2e4..64b0f65 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -117,3 +117,10 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 err:
 	panic("davinci_common_init: SoC Initialization failed\n");
 }
+
+void __init davinci_init_late(void)
+{
+	davinci_cpufreq_init();
+	davinci_pm_init();
+	davinci_clk_disable_unused();
+}
diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
index 031048f..4729eaa 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -240,10 +240,9 @@ static struct platform_driver davinci_cpufreq_driver = {
 	.remove = __exit_p(davinci_cpufreq_remove),
 };
 
-static int __init davinci_cpufreq_init(void)
+int __init davinci_cpufreq_init(void)
 {
 	return platform_driver_probe(&davinci_cpufreq_driver,
 							davinci_cpufreq_probe);
 }
-late_initcall(davinci_cpufreq_init);
 
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 5cd39a4..bdc4aa8 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -84,6 +84,25 @@ extern struct davinci_soc_info davinci_soc_info;
 extern void davinci_common_init(struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 void davinci_restart(char mode, const char *cmd);
+void davinci_init_late(void);
+
+#ifdef CONFIG_DAVINCI_RESET_CLOCKS
+int davinci_clk_disable_unused(void);
+#else
+static inline int davinci_clk_disable_unused(void) { return 0; }
+#endif
+
+#ifdef CONFIG_CPU_FREQ
+int davinci_cpufreq_init(void);
+#else
+static inline int davinci_cpufreq_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_SUSPEND
+int davinci_pm_init(void);
+#else
+static inline int davinci_pm_init(void) { return 0; }
+#endif
 
 /* standard place to map on-chip SRAMs; they *may* support DMA */
 #define SRAM_VIRT	0xfffe0000
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 04c49f7..eb8360b 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -152,8 +152,7 @@ static struct platform_driver davinci_pm_driver = {
 	.remove = __exit_p(davinci_pm_remove),
 };
 
-static int __init davinci_pm_init(void)
+int __init davinci_pm_init(void)
 {
 	return platform_driver_probe(&davinci_pm_driver, davinci_pm_probe);
 }
-late_initcall(davinci_pm_init);
-- 
1.7.5.4
