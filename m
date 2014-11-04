From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue,  4 Nov 2014 15:52:39 +0800
Subject: [PATCH 5/5] clk: rockchip: change DCLK_VOP0 to use new
 COMPOSITE_DIVOPS
In-Reply-To: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
References: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1415087559-19444-6-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI clock is actually provide by DCLK_VOP0, so we need this
patch to handle the HDMI clock correctly

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3288.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 0151140..073a719 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -396,8 +396,10 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 			RK3288_CLKSEL_CON(30), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3288_CLKGATE_CON(3), 4, GFLAGS),
 
-	COMPOSITE(DCLK_VOP0, "dclk_vop0", mux_pll_src_cpll_gpll_npll_p, 0,
+	COMPOSITE_DIVOPS(DCLK_VOP0, "dclk_vop0", mux_pll_src_cpll_gpll_npll_p,
+			(CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT),
 			RK3288_CLKSEL_CON(27), 0, 2, MFLAGS, 8, 8, DFLAGS,
+			&dclk_vop_ops,
 			RK3288_CLKGATE_CON(3), 1, GFLAGS),
 	COMPOSITE(DCLK_VOP1, "dclk_vop1", mux_pll_src_cpll_gpll_npll_p, 0,
 			RK3288_CLKSEL_CON(29), 6, 2, MFLAGS, 8, 8, DFLAGS,
-- 
1.9.1
