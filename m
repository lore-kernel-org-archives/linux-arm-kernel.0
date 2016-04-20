From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 20 Apr 2016 19:12:10 +0800
Subject: [PATCH 6/6] clk: rockchip: rk3399: fix the gate bit for i2c4 and i2c8
In-Reply-To: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
References: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1461150730-29787-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gate bits of the i2c4 and i2c8 are incorrect due to the manual
error, we need to fix them.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index e81cc85..3c5ab39 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1411,11 +1411,11 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 
 	COMPOSITE_NOMUX(SCLK_I2C4_PMU, "clk_i2c4_pmu", "ppll", 0,
 			RK3399_PMU_CLKSEL_CON(3), 0, 7, DFLAGS,
-			RK3399_PMU_CLKGATE_CON(0), 11, GFLAGS),
+			RK3399_PMU_CLKGATE_CON(0), 10, GFLAGS),
 
 	COMPOSITE_NOMUX(SCLK_I2C8_PMU, "clk_i2c8_pmu", "ppll", 0,
 			RK3399_PMU_CLKSEL_CON(2), 8, 7, DFLAGS,
-			RK3399_PMU_CLKGATE_CON(0), 10, GFLAGS),
+			RK3399_PMU_CLKGATE_CON(0), 11, GFLAGS),
 
 	DIV(0, "clk_32k_suspend_pmu", "xin24m", CLK_IGNORE_UNUSED,
 			RK3399_PMU_CLKSEL_CON(4), 0, 10, DFLAGS),
-- 
1.7.9.5
