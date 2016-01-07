From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu,  7 Jan 2016 20:17:35 +0800
Subject: [PATCH v2 3/5] clk: rockchip: rk3036: fix the div offset for emac
 clock
In-Reply-To: <1452169057-24467-1-git-send-email-zhengxing@rock-chips.com>
References: <1452169057-24467-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1452169057-24467-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to reference to old version TRM, there are incorrect emac clock node.
The SEL_21_9 is used for the parent div, the SEL_21_4 is used for the
child div.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 04b5249..1f00fab 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -344,12 +344,12 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(10), 5, GFLAGS),
 
 	COMPOSITE_NOGATE(0, "mac_pll_src", mux_pll_src_3plls_p, 0,
-			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 4, 5, DFLAGS),
+			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 9, 5, DFLAGS),
 	MUX(SCLK_MACREF, "mac_clk_ref", mux_mac_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(21), 3, 1, MFLAGS),
 
 	COMPOSITE_NOMUX(SCLK_MAC, "mac_clk", "mac_clk_ref", 0,
-			RK2928_CLKSEL_CON(21), 9, 5, DFLAGS,
+			RK2928_CLKSEL_CON(21), 4, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 6, GFLAGS),
 
 	MUX(SCLK_HDMI, "dclk_hdmi", mux_dclk_p, 0,
-- 
1.7.9.5
