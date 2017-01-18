From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Wed, 18 Jan 2017 13:42:39 +0800
Subject: [PATCH v2 2/3] clk: rockchip: use rk3288 vip_out clock ids
In-Reply-To: <1484718161-27702-1-git-send-email-jacob-chen@iotwrt.com>
References: <1484718161-27702-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1484718161-27702-2-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference the newly added vip clock-ids in the clock-tree.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 39af05a..3d02aa2 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -469,7 +469,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE_NODIV(0, "vip_src", mux_pll_src_cpll_gpll_p, 0,
 			RK3288_CLKSEL_CON(26), 8, 1, MFLAGS,
 			RK3288_CLKGATE_CON(3), 7, GFLAGS),
-	COMPOSITE_NOGATE(0, "sclk_vip_out", mux_vip_out_p, 0,
+	COMPOSITE_NOGATE(SCLK_VIP_OUT, "sclk_vip_out", mux_vip_out_p, 0,
 			RK3288_CLKSEL_CON(26), 15, 1, MFLAGS, 9, 5, DFLAGS),
 
 	DIV(0, "pclk_pd_alive", "gpll", 0,
-- 
2.7.4
