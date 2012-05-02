From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:31 +0800
Subject: [PATCH 06/15] ARM: msm: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-msm/board-halibut.c      |    6 ++++++
 arch/arm/mach-msm/board-mahimahi.c     |    6 ++++++
 arch/arm/mach-msm/board-msm7x27.c      |    9 +++++++++
 arch/arm/mach-msm/board-msm7x30.c      |    8 ++++++++
 arch/arm/mach-msm/board-msm8960.c      |    7 +++++++
 arch/arm/mach-msm/board-msm8x60.c      |   10 ++++++++++
 arch/arm/mach-msm/board-qsd8x50.c      |    7 +++++++
 arch/arm/mach-msm/board-sapphire.c     |    6 ++++++
 arch/arm/mach-msm/board-trout.c        |    6 ++++++
 arch/arm/mach-msm/include/mach/board.h |    6 ++++++
 arch/arm/mach-msm/smd_debug.c          |    3 +--
 11 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 26aac36..4fa3e99 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -94,6 +94,11 @@ static void __init halibut_map_io(void)
 	msm_clock_init(msm_clocks_7x01a, msm_num_clocks_7x01a);
 }
 
+static void __init halibut_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
 	.atag_offset	= 0x100,
 	.fixup		= halibut_fixup,
@@ -101,5 +106,6 @@ MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
 	.init_early	= halibut_init_early,
 	.init_irq	= halibut_init_irq,
 	.init_machine	= halibut_init,
+	.init_late	= halibut_init_late,
 	.timer		= &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-mahimahi.c b/arch/arm/mach-msm/board-mahimahi.c
index 5a4882f..cf1f89a 100644
--- a/arch/arm/mach-msm/board-mahimahi.c
+++ b/arch/arm/mach-msm/board-mahimahi.c
@@ -71,6 +71,11 @@ static void __init mahimahi_map_io(void)
 	msm_clock_init();
 }
 
+static void __init mahimahi_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 extern struct sys_timer msm_timer;
 
 MACHINE_START(MAHIMAHI, "mahimahi")
@@ -79,5 +84,6 @@ MACHINE_START(MAHIMAHI, "mahimahi")
 	.map_io		= mahimahi_map_io,
 	.init_irq	= msm_init_irq,
 	.init_machine	= mahimahi_init,
+	.init_late	= mahimahi_init_late,
 	.timer		= &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-msm7x27.c b/arch/arm/mach-msm/board-msm7x27.c
index 6d84ee7..451ab1d 100644
--- a/arch/arm/mach-msm/board-msm7x27.c
+++ b/arch/arm/mach-msm/board-msm7x27.c
@@ -128,11 +128,17 @@ static void __init msm7x2x_map_io(void)
 #endif
 }
 
+static void __init msm7x2x_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 MACHINE_START(MSM7X27_SURF, "QCT MSM7x27 SURF")
 	.atag_offset	= 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
+	.init_late	= msm7x2x_init_late,
 	.timer		= &msm_timer,
 MACHINE_END
 
@@ -141,6 +147,7 @@ MACHINE_START(MSM7X27_FFA, "QCT MSM7x27 FFA")
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
+	.init_late	= msm7x2x_init_late,
 	.timer		= &msm_timer,
 MACHINE_END
 
@@ -149,6 +156,7 @@ MACHINE_START(MSM7X25_SURF, "QCT MSM7x25 SURF")
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
+	.init_late	= msm7x2x_init_late,
 	.timer		= &msm_timer,
 MACHINE_END
 
@@ -157,5 +165,6 @@ MACHINE_START(MSM7X25_FFA, "QCT MSM7x25 FFA")
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
+	.init_late	= msm7x2x_init_late,
 	.timer		= &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index db81ed5..6095d35 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -120,6 +120,11 @@ static void __init msm7x30_map_io(void)
 	msm_clock_init(msm_clocks_7x30, msm_num_clocks_7x30);
 }
 
+static void __init msm7x30_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 	.atag_offset = 0x100,
 	.fixup = msm7x30_fixup,
@@ -127,6 +132,7 @@ MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
+	.init_late = msm7x30_init_late,
 	.timer = &msm_timer,
 MACHINE_END
 
@@ -137,6 +143,7 @@ MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
+	.init_late = msm7x30_init_late,
 	.timer = &msm_timer,
 MACHINE_END
 
@@ -147,5 +154,6 @@ MACHINE_START(MSM7X30_FLUID, "QCT MSM7X30 FLUID")
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
+	.init_late = msm7x30_init_late,
 	.timer = &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index ed35981..65f4a1d 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -93,6 +93,11 @@ static void __init msm8960_rumi3_init(void)
 	platform_add_devices(rumi3_devices, ARRAY_SIZE(rumi3_devices));
 }
 
+static void __init msm8960_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
 	.fixup = msm8960_fixup,
 	.reserve = msm8960_reserve,
@@ -101,6 +106,7 @@ MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
 	.timer = &msm_timer,
 	.handle_irq = gic_handle_irq,
 	.init_machine = msm8960_sim_init,
+	.init_late = msm8960_init_late,
 MACHINE_END
 
 MACHINE_START(MSM8960_RUMI3, "QCT MSM8960 RUMI3")
@@ -111,5 +117,6 @@ MACHINE_START(MSM8960_RUMI3, "QCT MSM8960 RUMI3")
 	.timer = &msm_timer,
 	.handle_irq = gic_handle_irq,
 	.init_machine = msm8960_rumi3_init,
+	.init_late = msm8960_init_late,
 MACHINE_END
 
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 962e711..62f2c93 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -68,6 +68,11 @@ static void __init msm8x60_init(void)
 {
 }
 
+static void __init msm8x60_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 #ifdef CONFIG_OF
 static struct of_dev_auxdata msm_auxdata_lookup[] __initdata = {
 	{}
@@ -106,6 +111,7 @@ MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
 	.init_irq = msm8x60_init_irq,
 	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
+	.init_late = msm8x60_init_late,
 	.timer = &msm_timer,
 MACHINE_END
 
@@ -116,6 +122,7 @@ MACHINE_START(MSM8X60_SURF, "QCT MSM8X60 SURF")
 	.init_irq = msm8x60_init_irq,
 	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
+	.init_late = msm8x60_init_late,
 	.timer = &msm_timer,
 MACHINE_END
 
@@ -126,6 +133,7 @@ MACHINE_START(MSM8X60_SIM, "QCT MSM8X60 SIMULATOR")
 	.init_irq = msm8x60_init_irq,
 	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
+	.init_late = msm8x60_init_late,
 	.timer = &msm_timer,
 MACHINE_END
 
@@ -136,6 +144,7 @@ MACHINE_START(MSM8X60_FFA, "QCT MSM8X60 FFA")
 	.init_irq = msm8x60_init_irq,
 	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
+	.init_late = msm8x60_init_late,
 	.timer = &msm_timer,
 MACHINE_END
 
@@ -145,6 +154,7 @@ DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.map_io = msm8x60_map_io,
 	.init_irq = msm8x60_init_irq,
 	.init_machine = msm8x60_dt_init,
+	.init_late = msm8x60_init_late,
 	.timer = &msm_timer,
 	.dt_compat = msm8x60_fluid_match,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 7e8909c..dd625aa 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -191,11 +191,17 @@ static void __init qsd8x50_init(void)
 	qsd8x50_init_mmc();
 }
 
+static void __init qsd8x50_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 	.atag_offset = 0x100,
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
+	.init_late = qsd8x50_init_late,
 	.timer = &msm_timer,
 MACHINE_END
 
@@ -204,5 +210,6 @@ MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
+	.init_late = qsd8x50_init_late,
 	.timer = &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index 4a8ea0d..2e569ab 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -101,6 +101,11 @@ static void __init sapphire_map_io(void)
 	msm_clock_init();
 }
 
+static void __init sapphire_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 MACHINE_START(SAPPHIRE, "sapphire")
 /* Maintainer: Brian Swetland <swetland@google.com> */
 	.atag_offset    = 0x100,
@@ -108,5 +113,6 @@ MACHINE_START(SAPPHIRE, "sapphire")
 	.map_io         = sapphire_map_io,
 	.init_irq       = sapphire_init_irq,
 	.init_machine   = sapphire_init,
+	.init_late      = sapphire_init_late,
 	.timer          = &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index d4060a3..bbe13f1 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -98,6 +98,11 @@ static void __init trout_map_io(void)
 	msm_clock_init(msm_clocks_7x01a, msm_num_clocks_7x01a);
 }
 
+static void __init trout_init_late(void)
+{
+	smd_debugfs_init();
+}
+
 MACHINE_START(TROUT, "HTC Dream")
 	.atag_offset	= 0x100,
 	.fixup		= trout_fixup,
@@ -105,5 +110,6 @@ MACHINE_START(TROUT, "HTC Dream")
 	.init_early	= trout_init_early,
 	.init_irq	= trout_init_irq,
 	.init_machine	= trout_init,
+	.init_late	= trout_init_late,
 	.timer		= &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/include/mach/board.h b/arch/arm/mach-msm/include/mach/board.h
index 2ce8f1f..435f8ed 100644
--- a/arch/arm/mach-msm/include/mach/board.h
+++ b/arch/arm/mach-msm/include/mach/board.h
@@ -47,4 +47,10 @@ int __init msm_add_sdcc(unsigned int controller,
 			struct msm_mmc_platform_data *plat,
 			unsigned int stat_irq, unsigned long stat_irq_flags);
 
+#if defined(CONFIG_MSM_SMD) && defined(CONFIG_DEBUG_FS)
+int smd_debugfs_init(void);
+#else
+static inline int smd_debugfs_init(void) { return 0; }
+#endif
+
 #endif
diff --git a/arch/arm/mach-msm/smd_debug.c b/arch/arm/mach-msm/smd_debug.c
index c56df9e..8056b3e 100644
--- a/arch/arm/mach-msm/smd_debug.c
+++ b/arch/arm/mach-msm/smd_debug.c
@@ -216,7 +216,7 @@ static void debug_create(const char *name, umode_t mode,
 	debugfs_create_file(name, mode, dent, fill, &debug_ops);
 }
 
-static int smd_debugfs_init(void)
+int __init smd_debugfs_init(void)
 {
 	struct dentry *dent;
 
@@ -234,7 +234,6 @@ static int smd_debugfs_init(void)
 	return 0;
 }
 
-late_initcall(smd_debugfs_init);
 #endif
 
 
-- 
1.7.5.4
