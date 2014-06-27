From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 27 Jun 2014 11:11:38 +0300
Subject: [PATCH 5/6] clk: tegra: Add soctherm and tsensor clocks to Tegra124
 init table
In-Reply-To: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1403856699-2140-6-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the two clocks, soctherm and tsensor, to the T124 initialization table.
They are required for soctherm-based thermal sensing.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Peter, one more zero for TSENSOR, please :)
 drivers/clk/tegra/clk-tegra124.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 80efe51..abeec63 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1369,6 +1369,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{TEGRA124_CLK_XUSB_HS_SRC, TEGRA124_CLK_PLL_U_60M, 60000000, 0},
 	{TEGRA124_CLK_XUSB_FALCON_SRC, TEGRA124_CLK_PLL_RE_OUT, 224000000, 0},
 	{TEGRA124_CLK_XUSB_HOST_SRC, TEGRA124_CLK_PLL_RE_OUT, 112000000, 0},
+	{TEGRA124_CLK_SOC_THERM, TEGRA124_CLK_PLL_P, 51000000, 0},
+	{TEGRA124_CLK_TSENSOR, TEGRA124_CLK_CLK_M, 400000, 0},
 	/* This MUST be the last entry. */
 	{TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0},
 };
-- 
1.8.1.5
