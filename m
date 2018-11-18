From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Sun, 18 Nov 2018 13:16:12 +0900
Subject: [PATCH] clk: rockchip: fix I2S1 clock gate register for rk3328
Message-ID: <20181118041612.2773-1-katsuhiro@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes definition of I2S1 clock gate register for rk3328.
Current setting is not related I2S clocks.
  - bit6 of CRU_CLKGATE_CON0 means clk_ddrmon_en
  - bit6 of CRU_CLKGATE_CON1 means clk_i2s1_en

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/rockchip/clk-rk3328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 2c5426607790..1eb46aa8b2fa 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -392,7 +392,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKGATE_CON(1), 5, GFLAGS,
 			&rk3328_i2s1_fracmux),
 	GATE(SCLK_I2S1, "clk_i2s1", "i2s1_pre", CLK_SET_RATE_PARENT,
-			RK3328_CLKGATE_CON(0), 6, GFLAGS),
+			RK3328_CLKGATE_CON(1), 6, GFLAGS),
 	COMPOSITE_NODIV(SCLK_I2S1_OUT, "i2s1_out", mux_i2s1out_p, 0,
 			RK3328_CLKSEL_CON(8), 12, 1, MFLAGS,
 			RK3328_CLKGATE_CON(1), 7, GFLAGS),
-- 
2.19.1
