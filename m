From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 28 Dec 2015 17:03:51 +0800
Subject: [RESEND PATCH v1 2/4] clk: rockchip: rk3036: fix uarts clock error
In-Reply-To: <1451293433-32392-1-git-send-email-zhengxing@rock-chips.com>
References: <1451293433-32392-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1451293433-32392-3-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a copy-paste error the uart1 and uart2 clock div set
incorrect, we should to fix it.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index d4ea7b6..47fe35b 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -222,11 +222,11 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(1), 8, GFLAGS),
 	COMPOSITE_NOMUX(0, "uart1_src", "uart_pll_clk", 0,
-			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
-			RK2928_CLKGATE_CON(1), 8, GFLAGS),
+			RK2928_CLKSEL_CON(14), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(1), 10, GFLAGS),
 	COMPOSITE_NOMUX(0, "uart2_src", "uart_pll_clk", 0,
-			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
-			RK2928_CLKGATE_CON(1), 8, GFLAGS),
+			RK2928_CLKSEL_CON(15), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(1), 12, GFLAGS),
 	COMPOSITE_FRAC(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(17), 0,
 			RK2928_CLKGATE_CON(1), 9, GFLAGS),
-- 
1.7.9.5
