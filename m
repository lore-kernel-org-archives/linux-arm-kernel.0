From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 16:37:17 +0300
Subject: [PATCH] clk: tegra: pllp_out2 divider is int only
Message-ID: <1370439442-30852-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pllp_out2 should be integer only, the fractional bit should always be 0.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index eb27764..5e029fe 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1203,8 +1203,8 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
 	/* PLLP_OUT2 */
 	clk = tegra_clk_register_divider("pll_p_out2_div", "pll_p",
 				clk_base + PLLP_OUTA, 0, TEGRA_DIVIDER_FIXED |
-				TEGRA_DIVIDER_ROUND_UP, 24, 8, 1,
-				&pll_div_lock);
+				TEGRA_DIVIDER_ROUND_UP | TEGRA_DIVIDER_INT, 24,
+				8, 1, &pll_div_lock);
 	clk = tegra_clk_register_pll_out("pll_p_out2", "pll_p_out2_div",
 				clk_base + PLLP_OUTA, 17, 16,
 				CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0,
-- 
1.7.7.rc0.72.g4b5ea.dirty
