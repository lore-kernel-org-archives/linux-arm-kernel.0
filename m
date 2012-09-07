From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  7 Sep 2012 14:43:48 +0200
Subject: [PATCH v4 6/6] ARM i.MX6q: Add ocram clkdev entry
In-Reply-To: <1347021828-23034-1-git-send-email-p.zabel@pengutronix.de>
References: <1347021828-23034-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1347021828-23034-7-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4233d9e..5912966 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -439,6 +439,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
 	clk_register_clkdev(clk[ahb], "ahb", NULL);
 	clk_register_clkdev(clk[cko1], "cko1", NULL);
+	clk_register_clkdev(clk[ocram], NULL, "900000.ocram");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clk[clks_init_on[i]]);
-- 
1.7.10.4
