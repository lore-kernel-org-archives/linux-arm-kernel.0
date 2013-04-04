From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 4 Apr 2013 14:35:33 +0530
Subject: [PATCH] clk: tegra: Add missing cdev1 and cdev2 clocks
Message-ID: <1365066333-2361-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register cdev1 and cdev2 peripheral clocks.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/clk/tegra/clk-tegra30.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 0681935..0e362ea 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1591,6 +1591,24 @@ static void __init tegra30_periph_clk_init(void)
 	clk_register_clkdev(clk, "afi", "tegra-pcie");
 	clks[afi] = clk;
 
+	/* cdev1 */
+	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL, CLK_IS_ROOT,
+				      26000000);
+	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_fixed", 0,
+				    clk_base, 0, 94, &periph_u_regs,
+				    periph_clk_enb_refcnt);
+	clk_register_clkdev(clk, "cdev1", NULL);
+	clks[cdev1] = clk;
+
+	/* cdev2 */
+	clk = clk_register_fixed_rate(NULL, "cdev2_fixed", NULL, CLK_IS_ROOT,
+				      26000000);
+	clk = tegra_clk_register_periph_gate("cdev2", "cdev2_fixed", 0,
+				    clk_base, 0, 93, &periph_u_regs,
+				    periph_clk_enb_refcnt);
+	clk_register_clkdev(clk, "cdev2", NULL);
+	clks[cdev2] = clk;
+
 	/* kfuse */
 	clk = tegra_clk_register_periph_gate("kfuse", "clk_m",
 				    TEGRA_PERIPH_ON_APB,
-- 
1.7.4.1
