From: markz@nvidia.com (Mark Zhang)
Date: Wed, 7 Aug 2013 19:25:08 +0800
Subject: [PATCH 4/5] clk: tegra: Set the clock parent of gr2d/gr3d to pll_c2
In-Reply-To: <1375874709-10438-1-git-send-email-markz@nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
Message-ID: <1375874709-10438-4-git-send-email-markz@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pll_m will be the parent of gr2d/gr3d if we don't do this.
And because pll_m runs at a high rate so gr2d/gr3d will be
unstable. So change the parent of them to pll_c2.

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index a45ea68..72976a2 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -2199,6 +2199,8 @@ static __initdata struct tegra_clk_init_table init_table[] = {
 	{i2s4, pll_a_out0, 11289600, 0},
 	{dfll_soc, pll_p, 51000000, 1},
 	{dfll_ref, pll_p, 51000000, 1},
+	{gr_2d, pll_c2, 300000000, 0},
+	{gr_3d, pll_c2, 300000000, 0},
 	{clk_max, clk_max, 0, 0}, /* This MUST be the last entry. */
 };
 
-- 
1.7.9.5
