From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 15:49:18 +0100
Subject: [PATCH v3 7/7] clocksource: cosmetic: Drop OF 'dependency' from
 symbols
In-Reply-To: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443451758-22717-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seeing the 'of' characters in a symbol that is being called from
ACPI seems to freak out people. So let's do a bit of pointless
renaming so that these folks do feel at home.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/time.c                              | 2 +-
 arch/arm/mach-omap2/timer.c                         | 4 ++--
 arch/arm/mach-rockchip/rockchip.c                   | 2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c              | 2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c            | 2 +-
 arch/arm/mach-spear/spear13xx.c                     | 2 +-
 arch/arm/mach-sunxi/sunxi.c                         | 2 +-
 arch/arm/mach-u300/core.c                           | 2 +-
 arch/arm/mach-ux500/timer.c                         | 2 +-
 arch/arm/mach-zynq/common.c                         | 2 +-
 arch/arm64/kernel/time.c                            | 2 +-
 arch/microblaze/kernel/setup.c                      | 2 +-
 arch/mips/pistachio/time.c                          | 2 +-
 arch/mips/ralink/clk.c                              | 2 +-
 arch/nios2/kernel/time.c                            | 2 +-
 arch/xtensa/kernel/time.c                           | 2 +-
 drivers/clocksource/Makefile                        | 2 +-
 drivers/clocksource/{clksrc-of.c => clksrc-probe.c} | 2 +-
 include/linux/clocksource.h                         | 4 ++--
 19 files changed, 21 insertions(+), 21 deletions(-)
 rename drivers/clocksource/{clksrc-of.c => clksrc-probe.c} (97%)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index a66e37e..97b22fa 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -120,6 +120,6 @@ void __init time_init(void)
 #ifdef CONFIG_COMMON_CLK
 		of_clk_init(NULL);
 #endif
-		clocksource_of_init();
+		clocksource_probe();
 	}
 }
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a556551..bef4183 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -647,7 +647,7 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-	clocksource_of_init();
+	clocksource_probe();
 }
 #else
 void __init omap4_local_timer_init(void)
@@ -663,7 +663,7 @@ void __init omap5_realtime_timer_init(void)
 	omap4_sync32k_timer_init();
 	realtime_counter_init();
 
-	clocksource_of_init();
+	clocksource_probe();
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index b6cf3b4..251c7b9 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -67,7 +67,7 @@ static void __init rockchip_timer_init(void)
 	}
 
 	of_clk_init(NULL);
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 static void __init rockchip_dt_init(void)
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 6bfa640..1e572a9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -97,7 +97,7 @@ static u32 __init r8a7779_read_mode_pins(void)
 static void __init r8a7779_init_time(void)
 {
 	r8a7779_clocks_init(r8a7779_read_mode_pins());
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 static const char *const r8a7779_compat_dt[] __initconst = {
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index aa33392..9eccde3 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -128,7 +128,7 @@ void __init rcar_gen2_timer_init(void)
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 	rcar_gen2_clocks_init(mode);
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 struct memory_reserve_config {
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index b7afce6..ca2f6a8 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -124,5 +124,5 @@ void __init spear13xx_timer_init(void)
 	clk_put(pclk);
 
 	spear_setup_of_timer();
-	clocksource_of_init();
+	clocksource_probe();
 }
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 65bab28..223c9e9 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -46,7 +46,7 @@ static void __init sun6i_timer_init(void)
 	of_clk_init(NULL);
 	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
 		sun6i_reset_init();
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 35670b1..546338b 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -408,7 +408,7 @@ static const char * u300_board_compat[] = {
 DT_MACHINE_START(U300_DT, "U300 S335/B335 (Device Tree)")
 	.map_io		= u300_map_io,
 	.init_irq	= u300_init_irq_dt,
-	.init_time	= clocksource_of_init,
+	.init_time	= clocksource_probe,
 	.init_machine	= u300_init_machine_dt,
 	.restart	= u300_restart,
 	.dt_compat      = u300_board_compat,
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index ff28d8a..8d2d233 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -44,5 +44,5 @@ void __init ux500_timer_init(void)
 
 dt_fail:
 	clksrc_dbx500_prcmu_init(prcmu_timer_base);
-	clocksource_of_init();
+	clocksource_probe();
 }
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5a6e4e2..6f39d03 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -154,7 +154,7 @@ static void __init zynq_timer_init(void)
 
 	zynq_clock_init();
 	of_clk_init(NULL);
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 static struct map_desc zynq_cortex_a9_scu_map __initdata = {
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 819a105..13339b6 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -67,7 +67,7 @@ void __init time_init(void)
 	u32 arch_timer_rate;
 
 	of_clk_init(NULL);
-	clocksource_of_init();
+	clocksource_probe();
 
 	tick_setup_hrtimer_broadcast();
 
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index ab5b488..89a2a93 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -194,7 +194,7 @@ void __init time_init(void)
 {
 	of_clk_init(NULL);
 	setup_cpuinfo_clk();
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/arch/mips/pistachio/time.c b/arch/mips/pistachio/time.c
index 8a37734..1022201 100644
--- a/arch/mips/pistachio/time.c
+++ b/arch/mips/pistachio/time.c
@@ -39,7 +39,7 @@ void __init plat_time_init(void)
 	struct clk *clk;
 
 	of_clk_init(NULL);
-	clocksource_of_init();
+	clocksource_probe();
 
 	np = of_get_cpu_node(0, NULL);
 	if (!np) {
diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index feb5a9b..25c4a61 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -75,5 +75,5 @@ void __init plat_time_init(void)
 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 	clk_put(clk);
-	clocksource_of_init();
+	clocksource_probe();
 }
diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index bbc3f91..e835dda 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -324,7 +324,7 @@ void __init time_init(void)
 	if (count < 2)
 		panic("%d timer is found, it needs 2 timers in system\n", count);
 
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 CLOCKSOURCE_OF_DECLARE(nios2_timer, ALTR_TIMER_COMPATIBLE, nios2_time_init);
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index b97767d..b9ad9fe 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -148,7 +148,7 @@ void __init time_init(void)
 	local_timer_setup(0);
 	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
 	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
-	clocksource_of_init();
+	clocksource_probe();
 }
 
 /*
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index b47be92..51856d5 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-of.o
+obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
diff --git a/drivers/clocksource/clksrc-of.c b/drivers/clocksource/clksrc-probe.c
similarity index 97%
rename from drivers/clocksource/clksrc-of.c
rename to drivers/clocksource/clksrc-probe.c
index a2105bd..7cb6c92 100644
--- a/drivers/clocksource/clksrc-of.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -24,7 +24,7 @@ extern struct of_device_id __clksrc_of_table[];
 static const struct of_device_id __clksrc_of_table_sentinel
 	__used __section(__clksrc_of_table_end);
 
-void __init clocksource_of_init(void)
+void __init clocksource_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 116645f..7784b59 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -247,9 +247,9 @@ extern int clocksource_i8253_init(void);
 	OF_DECLARE_1(clksrc, name, compat, fn)
 
 #ifdef CONFIG_CLKSRC_PROBE
-extern void clocksource_of_init(void);
+extern void clocksource_probe(void);
 #else
-static inline void clocksource_of_init(void) {}
+static inline void clocksource_probe(void) {}
 #endif
 
 #define CLOCKSOURCE_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.1.4
