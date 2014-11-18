From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Tue, 18 Nov 2014 12:10:43 +0100
Subject: [PATCH] clk: rockchip: fix parent clock for rk3188 hclk_lcdc1
Message-ID: <1416309043-29069-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent clock for hclk_lcdc1 was set to aclk_cpu instead of hclk_cpu.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 drivers/clk/rockchip/clk-rk3188.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index f88eb7d..e6cd483 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -410,7 +410,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	/* hclk_ahb2apb is part of a clk branch */
 	GATE(0, "hclk_vio_bus", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 12, GFLAGS),
 	GATE(HCLK_LCDC0, "hclk_lcdc0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 1, GFLAGS),
-	GATE(HCLK_LCDC1, "hclk_lcdc1", "aclk_cpu", 0, RK2928_CLKGATE_CON(6), 2, GFLAGS),
+	GATE(HCLK_LCDC1, "hclk_lcdc1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 2, GFLAGS),
 	GATE(HCLK_CIF0, "hclk_cif0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 4, GFLAGS),
 	GATE(HCLK_IPP, "hclk_ipp", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 9, GFLAGS),
 	GATE(HCLK_RGA, "hclk_rga", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 10, GFLAGS),
-- 
2.1.0
