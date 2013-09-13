From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:25:06 -0600
Subject: [PATCH 2/7] ARM: tegra: delete stale header content
In-Reply-To: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1379096711-26875-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

A few function prototypes were left in header files during code re-
organization. Delete them.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board.h | 6 ------
 arch/arm/mach-tegra/pm.h    | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 7b9a5bd..bcf5dbf 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -28,12 +28,6 @@
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
 
-#ifdef CONFIG_DEBUG_FS
-int tegra_clk_debugfs_init(void);
-#else
-static inline int tegra_clk_debugfs_init(void) { return 0; }
-#endif
-
 int __init tegra_powergate_init(void);
 #if defined(CONFIG_ARCH_TEGRA_2x_SOC) && defined(CONFIG_DEBUG_FS)
 int __init tegra_powergate_debugfs_init(void);
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index fe204e5..6e92a7c 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -37,9 +37,6 @@ void tegra30_sleep_core_init(void);
 
 extern unsigned long l2x0_saved_regs_addr;
 
-void save_cpu_arch_register(void);
-void restore_cpu_arch_register(void);
-
 void tegra_clear_cpu_in_lp2(void);
 bool tegra_set_cpu_in_lp2(void);
 
-- 
1.8.1.5
