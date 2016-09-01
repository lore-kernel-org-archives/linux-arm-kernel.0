From: zyw@rock-chips.com (Chris Zhong)
Date: Thu,  1 Sep 2016 15:53:28 -0700
Subject: [PATCH 3/3] clk: rockchip: use the dclk_vop_frac clock ids
In-Reply-To: <1472770408-32278-1-git-send-email-zyw@rock-chips.com>
References: <1472770408-32278-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1472770408-32278-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yakir Yang <ykk@rock-chips.com>

Export the dclk_vop_frac out, so we can set the dclk_vop as the
child of dclk_vop_frac, and then we can start to take use of
the fractional dividers.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 4c59f2b..2c7cba7 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1168,7 +1168,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(49), 8, 2, MFLAGS, 0, 8, DFLAGS,
 			RK3399_CLKGATE_CON(10), 12, GFLAGS),
 
-	COMPOSITE_FRACMUX_NOGATE(0, "dclk_vop0_frac", "dclk_vop0_div", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP0_FRAC, "dclk_vop0_frac", "dclk_vop0_div", 0,
 			RK3399_CLKSEL_CON(106), 0,
 			&rk3399_dclk_vop0_fracmux),
 
@@ -1198,7 +1198,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(50), 8, 2, MFLAGS, 0, 8, DFLAGS,
 			RK3399_CLKGATE_CON(10), 13, GFLAGS),
 
-	COMPOSITE_FRACMUX_NOGATE(0, "dclk_vop1_frac", "dclk_vop1_div", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_NOGATE(DCLK_VOP1_FRAC, "dclk_vop1_frac", "dclk_vop1_div", 0,
 			RK3399_CLKSEL_CON(107), 0,
 			&rk3399_dclk_vop1_fracmux),
 
-- 
1.9.1
