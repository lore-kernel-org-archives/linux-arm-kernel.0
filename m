From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 16 Jul 2014 11:54:20 +0300
Subject: [PATCH v3 5/8] clk: tegra: Add SATA clocks to Tegra124 initialization
 table
In-Reply-To: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1405500863-19696-6-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds two clocks, SATA and SATA_OOB, to the Tegra124 clock initialization
table. The clocks are needed for working SATA support.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Already ACKed.

 drivers/clk/tegra/clk-tegra124.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 80efe51..6770787 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1369,6 +1369,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{TEGRA124_CLK_XUSB_HS_SRC, TEGRA124_CLK_PLL_U_60M, 60000000, 0},
 	{TEGRA124_CLK_XUSB_FALCON_SRC, TEGRA124_CLK_PLL_RE_OUT, 224000000, 0},
 	{TEGRA124_CLK_XUSB_HOST_SRC, TEGRA124_CLK_PLL_RE_OUT, 112000000, 0},
+	{TEGRA124_CLK_SATA, TEGRA124_CLK_PLL_P, 104000000, 0},
+	{TEGRA124_CLK_SATA_OOB, TEGRA124_CLK_PLL_P, 204000000, 0},
 	/* This MUST be the last entry. */
 	{TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0},
 };
-- 
1.8.1.5
