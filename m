From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 21 Jun 2016 12:53:30 +0800
Subject: [PATCH 4/5] clk: rockchip: rk3228: rename sclk_macphy_50m to
 sclk_mac_extclk
In-Reply-To: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
References: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1466484811-26923-5-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sclk_macphy_50m is confusing, the sclk_mac_extclk describes
a external clock  clearly.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3228.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 79a3db1..980d0da 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -151,8 +151,8 @@ PNAME(mux_uart0_p)		= { "uart0_src", "uart0_frac", "xin24m" };
 PNAME(mux_uart1_p)		= { "uart1_src", "uart1_frac", "xin24m" };
 PNAME(mux_uart2_p)		= { "uart2_src", "uart2_frac", "xin24m" };
 
-PNAME(mux_sclk_macphy_50m_p)	= { "ext_gmac", "phy_50m_out" };
-PNAME(mux_sclk_gmac_pre_p)	= { "sclk_gmac_src", "sclk_macphy_50m" };
+PNAME(mux_sclk_mac_extclk_p)	= { "ext_gmac", "phy_50m_out" };
+PNAME(mux_sclk_gmac_pre_p)	= { "sclk_gmac_src", "sclk_mac_extclk" };
 PNAME(mux_sclk_macphy_p)	= { "sclk_gmac_src", "ext_gmac" };
 
 static struct rockchip_pll_clock rk3228_pll_clks[] __initdata = {
@@ -502,7 +502,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	COMPOSITE(0, "sclk_gmac_src", mux_pll_src_2plls_p, 0,
 			RK2928_CLKSEL_CON(5), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 7, GFLAGS),
-	MUX(0, "sclk_macphy_50m", mux_sclk_macphy_50m_p, 0,
+	MUX(0, "sclk_mac_extclk", mux_sclk_mac_extclk_p, 0,
 			RK2928_CLKSEL_CON(29), 10, 1, MFLAGS),
 	MUX(0, "sclk_gmac_pre", mux_sclk_gmac_pre_p, 0,
 			RK2928_CLKSEL_CON(5), 5, 1, MFLAGS),
-- 
1.7.9.5
