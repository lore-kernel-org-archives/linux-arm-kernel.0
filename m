From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Oct 2013 12:50:04 +0800
Subject: [PATCH V2 2/6] ARM: tegra: add PMC compatible value for Tegar124
In-Reply-To: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
References: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381207808-14734-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMC HW is not identical to the existing Tegra SoC. Hence add to it.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* new in v2
---
 arch/arm/mach-tegra/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 93a4dbc..3744af9 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -288,6 +288,7 @@ void tegra_pmc_suspend_init(void)
 #endif
 
 static const struct of_device_id matches[] __initconst = {
+	{ .compatible = "nvidia,tegra124-pmc" },
 	{ .compatible = "nvidia,tegra114-pmc" },
 	{ .compatible = "nvidia,tegra30-pmc" },
 	{ .compatible = "nvidia,tegra20-pmc" },
-- 
1.8.4
