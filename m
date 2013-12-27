From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 26 Dec 2013 16:44:23 -0800
Subject: [PATCH 3/7] clk: tegra: PLLD2 fixes for hdmi
In-Reply-To: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
References: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
Message-ID: <1388105067-24438-4-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Ung <davidu@nvidia.com>

Set correct pll_d2_out0 divider and correct the p div values for pll_d2.

Signed-off-by: David Ung <davidu@nvidia.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/tegra/clk-tegra124.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 14c3f2f..0fc9126 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -619,12 +619,11 @@ static struct tegra_clk_pll_params pll_d_params = {
 };
 
 static struct tegra_clk_pll_freq_table tegra124_pll_d2_freq_table[] = {
-	{ 12000000, 148500000,  99, 1, 8},
-	{ 12000000, 594000000,  99, 1, 1},
-	{ 13000000, 594000000,  91, 1, 1},      /* actual: 591.5 MHz */
-	{ 16800000, 594000000,  71, 1, 1},      /* actual: 596.4 MHz */
-	{ 19200000, 594000000,  62, 1, 1},      /* actual: 595.2 MHz */
-	{ 26000000, 594000000,  91, 2, 1},      /* actual: 591.5 MHz */
+	{ 12000000, 594000000,  99, 1, 2},
+	{ 13000000, 594000000,  91, 1, 2},      /* actual: 591.5 MHz */
+	{ 16800000, 594000000,  71, 1, 2},      /* actual: 596.4 MHz */
+	{ 19200000, 594000000,  62, 1, 2},      /* actual: 595.2 MHz */
+	{ 26000000, 594000000,  91, 2, 2},      /* actual: 591.5 MHz */
 	{ 0, 0, 0, 0, 0, 0 },
 };
 
@@ -1295,9 +1294,9 @@ static void __init tegra124_pll_init(void __iomem *clk_base,
 	clk_register_clkdev(clk, "pll_d2", NULL);
 	clks[TEGRA124_CLK_PLL_D2] = clk;
 
-	/* PLLD2_OUT0 ?? */
+	/* PLLD2_OUT0 */
 	clk = clk_register_fixed_factor(NULL, "pll_d2_out0", "pll_d2",
-					CLK_SET_RATE_PARENT, 1, 2);
+					CLK_SET_RATE_PARENT, 1, 1);
 	clk_register_clkdev(clk, "pll_d2_out0", NULL);
 	clks[TEGRA124_CLK_PLL_D2_OUT0] = clk;
 
-- 
1.8.5.1
