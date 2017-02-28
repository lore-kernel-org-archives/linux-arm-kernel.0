From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Feb 2017 06:14:19 +0100
Subject: [PATCH 3/4] clk: rockchip: assign the SCLK_UARTPLL clock id on rk3036
In-Reply-To: <20170228051420.7214-1-heiko@sntech.de>
References: <20170228051420.7214-1-heiko@sntech.de>
Message-ID: <20170228051420.7214-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign it to the matching clock in the clock driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index dcde70f4c105..d10934b63a0d 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -242,7 +242,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(2), 7, 1, MFLAGS,
 			RK2928_CLKGATE_CON(2), 5, GFLAGS),
 
-	MUX(0, "uart_pll_clk", mux_pll_src_apll_dpll_gpll_usb480m_p, 0,
+	MUX(SCLK_UARTPLL, "uart_pll_clk", mux_pll_src_apll_dpll_gpll_usb480m_p, 0,
 			RK2928_CLKSEL_CON(13), 10, 2, MFLAGS),
 	COMPOSITE_NOMUX(0, "uart0_src", "uart_pll_clk", 0,
 			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
-- 
2.11.0
