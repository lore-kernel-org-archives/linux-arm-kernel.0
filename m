From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 27 Aug 2012 17:38:37 -0700
Subject: [PATCH] ARM: tegra: remove tegra_timer from tegra_list_clks
Message-ID: <1346114317-28486-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

tegra_time is a struct sys_timer, not a struct clk, so can't be included
in an array of struct clk *.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/tegra20_clocks_data.c |    1 -
 arch/arm/mach-tegra/tegra30_clocks_data.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra20_clocks_data.c b/arch/arm/mach-tegra/tegra20_clocks_data.c
index b9cb82b..be57764 100644
--- a/arch/arm/mach-tegra/tegra20_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra20_clocks_data.c
@@ -926,7 +926,6 @@ PERIPH_CLK(pcie_xclk,	NULL,		  "pcie_xclk",  74,     0,	26000000,  mux_clk_m,
 static struct clk *tegra_list_clks[] = {
 	&tegra_apbdma,
 	&tegra_rtc,
-	&tegra_timer,
 	&tegra_i2s1,
 	&tegra_i2s2,
 	&tegra_spdif_out,
diff --git a/arch/arm/mach-tegra/tegra30_clocks_data.c b/arch/arm/mach-tegra/tegra30_clocks_data.c
index 3d2e553..d92cb55 100644
--- a/arch/arm/mach-tegra/tegra30_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra30_clocks_data.c
@@ -1143,7 +1143,6 @@ struct clk *tegra_list_clks[] = {
 	&tegra_apbdma,
 	&tegra_rtc,
 	&tegra_kbc,
-	&tegra_timer,
 	&tegra_kfuse,
 	&tegra_fuse,
 	&tegra_fuse_burn,
-- 
1.7.9.5
