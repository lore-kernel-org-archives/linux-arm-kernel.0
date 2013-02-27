From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 27 Feb 2013 10:27:42 +0800
Subject: [PATCH V2 1/2] ARM: tegra: pmc: add specific compatible DT string for
 Tegra30 and Tegra114
Message-ID: <1361932063-13263-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMC HW is not 100% compatible across all Tegra series. We need to
specify each of them in the DT match table.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* fix the typo and the chip order in DT match table
---
 arch/arm/mach-tegra/pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index d4fdb5f..5d79d34 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -36,6 +36,8 @@ static inline void tegra_pmc_writel(u32 val, u32 reg)
 
 #ifdef CONFIG_OF
 static const struct of_device_id matches[] __initconst = {
+	{ .compatible = "nvidia,tegra114-pmc" },
+	{ .compatible = "nvidia,tegra30-pmc" },
 	{ .compatible = "nvidia,tegra20-pmc" },
 	{ }
 };
-- 
1.8.1.1
