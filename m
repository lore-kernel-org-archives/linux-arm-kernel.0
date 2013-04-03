From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 3 Apr 2013 17:40:46 +0300
Subject: [PATCH v9 12/14] clk: tegra: devicetree match for nvidia, tegra114-car
In-Reply-To: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1365000110-8916-13-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk.c |    1 +
 drivers/clk/tegra/clk.h |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 70b7a47..923ca7e 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -77,6 +77,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 static const struct of_device_id tegra_dt_clk_match[] = {
 	{ .compatible = "nvidia,tegra20-car", .data = tegra20_clock_init },
 	{ .compatible = "nvidia,tegra30-car", .data = tegra30_clock_init },
+	{ .compatible = "nvidia,tegra114-car", .data = tegra114_clock_init },
 	{ }
 };
 
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index fb48f04..e056562 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -583,6 +583,12 @@ void tegra30_clock_init(struct device_node *np);
 static inline void tegra30_clock_init(struct device_node *np) {}
 #endif /* CONFIG_ARCH_TEGRA_3x_SOC */
 
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+void tegra114_clock_init(struct device_node *np);
+#else
+static inline void tegra114_clock_init(struct device_node *np) {}
+#endif /* CONFIG_ARCH_TEGRA114_SOC */
+
 typedef void (*tegra_clk_apply_init_table_func)(void);
 extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
 
-- 
1.7.7.rc0.72.g4b5ea.dirty
