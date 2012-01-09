From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 9 Jan 2012 17:35:13 +0200
Subject: [RESEND PATCH v2 3/3] ARM: tegra: enable tegra30 clock framework
In-Reply-To: <1326123315-32670-1-git-send-email-pdeschrijver@nvidia.com>
References: <1326123315-32670-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1326123315-32670-4-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/Makefile |    1 +
 arch/arm/mach-tegra/clock.h  |    1 +
 arch/arm/mach-tegra/common.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e8de030..8628421 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= powergate.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o
diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
index 18f8b85..bc30065 100644
--- a/arch/arm/mach-tegra/clock.h
+++ b/arch/arm/mach-tegra/clock.h
@@ -160,6 +160,7 @@ struct tegra_clk_init_table {
 };
 
 void tegra2_init_clocks(void);
+void tegra30_init_clocks(void);
 void clk_init(struct clk *clk);
 struct clk *tegra_get_clock_by_name(const char *name);
 int clk_reparent(struct clk *c, struct clk *parent);
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 9f1bd0c..109bdc0 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -123,6 +123,7 @@ void __init tegra20_init_early(void)
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 void __init tegra30_init_early(void)
 {
+	tegra30_init_clocks();
 	tegra_init_cache(0x441, 0x551);
 }
 #endif
-- 
1.7.7.rc0.72.g4b5ea.dirty
