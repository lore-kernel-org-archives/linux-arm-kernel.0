From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Jun 2012 16:32:28 -0600
Subject: [PATCH] ARM: tegra: use of_default_bus_match_table
Message-ID: <1340922748-24131-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

of_default_bus_match_table is a table of default bus types supported by
of_platform_populate(). Since Tegra has no need to support any specific
custom list of bus types, modify the DT board files to use this default
list.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-dt-tegra20.c |    7 +------
 arch/arm/mach-tegra/board-dt-tegra30.c |    7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 8b4e6e1..510b485 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -81,11 +81,6 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
-static struct of_device_id tegra_dt_match_table[] __initdata = {
-	{ .compatible = "simple-bus", },
-	{}
-};
-
 static void __init tegra_dt_init(void)
 {
 	tegra_clk_init_from_table(tegra_dt_clk_init_table);
@@ -94,7 +89,7 @@ static void __init tegra_dt_init(void)
 	 * Finished with the static registrations now; fill in the missing
 	 * devices
 	 */
-	of_platform_populate(NULL, tegra_dt_match_table,
+	of_platform_populate(NULL, of_default_bus_match_table,
 				tegra20_auxdata_lookup, NULL);
 }
 
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 4f76fa7..48a2ef8 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -36,11 +36,6 @@
 #include "board.h"
 #include "clock.h"
 
-static struct of_device_id tegra_dt_match_table[] __initdata = {
-	{ .compatible = "simple-bus", },
-	{}
-};
-
 struct of_dev_auxdata tegra30_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", 0x78000000, "sdhci-tegra.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", 0x78000200, "sdhci-tegra.1", NULL),
@@ -74,7 +69,7 @@ static void __init tegra30_dt_init(void)
 {
 	tegra_clk_init_from_table(tegra_dt_clk_init_table);
 
-	of_platform_populate(NULL, tegra_dt_match_table,
+	of_platform_populate(NULL, of_default_bus_match_table,
 				tegra30_auxdata_lookup, NULL);
 }
 
-- 
1.7.0.4
