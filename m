From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Apr 2012 23:38:44 +0800
Subject: [PATCH 16/17] ARM: tegra: use machine specific hook for late init
In-Reply-To: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335454725-13089-17-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Colin Cross <ccross@android.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-tegra/board-dt-tegra20.c |    1 +
 arch/arm/mach-tegra/board-dt-tegra30.c |    1 +
 arch/arm/mach-tegra/board-harmony.c    |    1 +
 arch/arm/mach-tegra/board-paz00.c      |    1 +
 arch/arm/mach-tegra/board-seaboard.c   |    3 +++
 arch/arm/mach-tegra/board-trimslice.c  |    1 +
 arch/arm/mach-tegra/board.h            |   16 ++++++++++++++++
 arch/arm/mach-tegra/clock.c            |    3 +--
 arch/arm/mach-tegra/common.c           |    7 +++++++
 arch/arm/mach-tegra/pinmux.c           |    3 +--
 arch/arm/mach-tegra/powergate.c        |    4 +---
 11 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 0952494..0f0da6c 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -142,6 +142,7 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_timer,
 	.init_machine	= tegra_dt_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 	.dt_compat	= tegra20_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 5f7c03e..09d21b2 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -80,6 +80,7 @@ DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_timer,
 	.init_machine	= tegra30_dt_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 	.dt_compat	= tegra30_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index c00aadb..987115a 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -191,5 +191,6 @@ MACHINE_START(HARMONY, "harmony")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_harmony_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 330afdf..2e8a4c6 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -221,5 +221,6 @@ MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_paz00_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index d669847..273eaaa 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -289,6 +289,7 @@ MACHINE_START(SEABOARD, "seaboard")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_seaboard_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 MACHINE_END
 
@@ -300,6 +301,7 @@ MACHINE_START(KAEN, "kaen")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_kaen_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 MACHINE_END
 
@@ -311,5 +313,6 @@ MACHINE_START(WARIO, "wario")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_wario_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index cd52820..0a2a0e5 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -180,5 +180,6 @@ MACHINE_START(TRIMSLICE, "trimslice")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_trimslice_init,
+	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 75d1543..80086c6 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -32,5 +32,21 @@ void __init tegra_init_irq(void);
 void __init tegra_dt_init_irq(void);
 int __init tegra_pcie_init(bool init_port0, bool init_port1);
 
+void tegra_init_late(void);
+
+#ifdef CONFIG_DEBUG_FS
+int tegra_clk_debugfs_init(void);
+int tegra_pinmux_debuginit(void);
+#else
+static inline int tegra_clk_debugfs_init(void) { return 0; }
+static inline int tegra_pinmux_debuginit(void) { return 0; }
+#endif
+
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC) && defined(CONFIG_DEBUG_FS)
+int __init tegra_powergate_debugfs_init(void);
+#else
+static inline int tegra_powergate_debugfs_init(void) { return 0; }
+#endif
+
 extern struct sys_timer tegra_timer;
 #endif
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index 8dad8d1..58f981c 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -642,7 +642,7 @@ static int clk_debugfs_register(struct clk *c)
 	return 0;
 }
 
-static int __init clk_debugfs_init(void)
+int __init tegra_clk_debugfs_init(void)
 {
 	struct clk *c;
 	struct dentry *d;
@@ -669,5 +669,4 @@ err_out:
 	return err;
 }
 
-late_initcall(clk_debugfs_init);
 #endif
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 22df10f..d5301b6 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -132,3 +132,10 @@ void __init tegra30_init_early(void)
 	tegra_powergate_init();
 }
 #endif
+
+void __init tegra_init_late(void)
+{
+	tegra_clk_debugfs_init();
+	tegra_pinmux_debuginit();
+	tegra_powergate_debugfs_init();
+}
diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
index ac35d2b..4cecf38 100644
--- a/arch/arm/mach-tegra/pinmux.c
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -975,7 +975,7 @@ static const struct file_operations debug_drive_fops = {
 	.release	= single_release,
 };
 
-static int __init tegra_pinmux_debuginit(void)
+int __init tegra_pinmux_debuginit(void)
 {
 	(void) debugfs_create_file("tegra_pinmux", S_IRUGO,
 					NULL, NULL, &debug_fops);
@@ -983,5 +983,4 @@ static int __init tegra_pinmux_debuginit(void)
 					NULL, NULL, &debug_drive_fops);
 	return 0;
 }
-late_initcall(tegra_pinmux_debuginit);
 #endif
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index c238699..f5b12fb 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -234,7 +234,7 @@ static const struct file_operations powergate_fops = {
 	.release	= single_release,
 };
 
-static int __init powergate_debugfs_init(void)
+int __init tegra_powergate_debugfs_init(void)
 {
 	struct dentry *d;
 	int err = -ENOMEM;
@@ -247,6 +247,4 @@ static int __init powergate_debugfs_init(void)
 	return err;
 }
 
-late_initcall(powergate_debugfs_init);
-
 #endif
-- 
1.7.5.4
