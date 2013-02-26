From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 26 Feb 2013 17:58:47 +0800
Subject: [PATCH 1/2] ARM: tegra: pmc: add specific compatible DT string for
 Tegra30 and Tegra114
Message-ID: <1361872727-4388-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMC HW dose not 100% compatible across all Tegra series. We need to
specify each of them in the DT match table.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index d4fdb5f..1b5a908 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -37,6 +37,8 @@ static inline void tegra_pmc_writel(u32 val, u32 reg)
 #ifdef CONFIG_OF
 static const struct of_device_id matches[] __initconst = {
 	{ .compatible = "nvidia,tegra20-pmc" },
+	{ .compatible = "nvidia,tegra30-pmc" },
+	{ .compatible = "nvidia,tegra114-pmc" },
 	{ }
 };
 #endif
-- 
1.8.1.1
