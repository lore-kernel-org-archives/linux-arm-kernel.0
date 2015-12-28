From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 28 Dec 2015 17:03:50 +0800
Subject: [RESEND PATCH v1 1/4] clk: rockchip: rk3036: fix the FLAGs for clock
 mux
In-Reply-To: <1451293433-32392-1-git-send-email-zhengxing@rock-chips.com>
References: <1451293433-32392-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1451293433-32392-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DFLAGS are used for the clock dividers, the CLKSEL_CON flags
of COMPOSITE_NODIV type should be MFLAGS.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 7333b053..d4ea7b6 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -204,16 +204,16 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
 
 	COMPOSITE_NODIV(SCLK_TIMER0, "sclk_timer0", mux_timer_p, CLK_IGNORE_UNUSED,
-			RK2928_CLKSEL_CON(2), 4, 1, DFLAGS,
+			RK2928_CLKSEL_CON(2), 4, 1, MFLAGS,
 			RK2928_CLKGATE_CON(1), 0, GFLAGS),
 	COMPOSITE_NODIV(SCLK_TIMER1, "sclk_timer1", mux_timer_p, CLK_IGNORE_UNUSED,
-			RK2928_CLKSEL_CON(2), 5, 1, DFLAGS,
+			RK2928_CLKSEL_CON(2), 5, 1, MFLAGS,
 			RK2928_CLKGATE_CON(1), 1, GFLAGS),
 	COMPOSITE_NODIV(SCLK_TIMER2, "sclk_timer2", mux_timer_p, CLK_IGNORE_UNUSED,
-			RK2928_CLKSEL_CON(2), 6, 1, DFLAGS,
+			RK2928_CLKSEL_CON(2), 6, 1, MFLAGS,
 			RK2928_CLKGATE_CON(2), 4, GFLAGS),
 	COMPOSITE_NODIV(SCLK_TIMER3, "sclk_timer3", mux_timer_p, CLK_IGNORE_UNUSED,
-			RK2928_CLKSEL_CON(2), 7, 1, DFLAGS,
+			RK2928_CLKSEL_CON(2), 7, 1, MFLAGS,
 			RK2928_CLKGATE_CON(2), 5, GFLAGS),
 
 	MUX(0, "uart_pll_clk", mux_pll_src_apll_dpll_gpll_usb480m_p, 0,
@@ -262,13 +262,13 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(3), 2, GFLAGS),
 
 	COMPOSITE_NODIV(0, "sclk_sdmmc_src", mux_mmc_src_p, 0,
-			RK2928_CLKSEL_CON(12), 8, 2, DFLAGS,
+			RK2928_CLKSEL_CON(12), 8, 2, MFLAGS,
 			RK2928_CLKGATE_CON(2), 11, GFLAGS),
 	DIV(SCLK_SDMMC, "sclk_sdmmc", "sclk_sdmmc_src", 0,
 			RK2928_CLKSEL_CON(11), 0, 7, DFLAGS),
 
 	COMPOSITE_NODIV(0, "sclk_sdio_src", mux_mmc_src_p, 0,
-			RK2928_CLKSEL_CON(12), 10, 2, DFLAGS,
+			RK2928_CLKSEL_CON(12), 10, 2, MFLAGS,
 			RK2928_CLKGATE_CON(2), 13, GFLAGS),
 	DIV(SCLK_SDIO, "sclk_sdio", "sclk_sdio_src", 0,
 			RK2928_CLKSEL_CON(11), 8, 7, DFLAGS),
-- 
1.7.9.5
