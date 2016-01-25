From: zhangqing@rock-chips.com (Zhang Qing)
Date: Mon, 25 Jan 2016 08:56:02 -0800
Subject: [PATCH v1 3/3] clk: rockchip: rk3368: enable the CLK_SET_RATE_PARENT
 flag for i2s_2ch
In-Reply-To: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
References: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1453740962-8556-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhangqing <zhangqing@rock-chips.com>

I2S_2CH set freq need to select parent and calculate parent freq.
so just mark it as the CLK_SET_RATE_PARENT flag.

Signed-off-by: zhangqing <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 58ef08b..5ceb536 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -363,7 +363,8 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	COMPOSITE_FRAC(0, "i2s_2ch_frac", "i2s_2ch_src", CLK_SET_RATE_PARENT,
 			RK3368_CLKSEL_CON(54), 0,
 			RK3368_CLKGATE_CON(5), 14, GFLAGS),
-	COMPOSITE_NODIV(SCLK_I2S_2CH, "sclk_i2s_2ch", mux_i2s_2ch_p, 0,
+	COMPOSITE_NODIV(SCLK_I2S_2CH, "sclk_i2s_2ch", mux_i2s_2ch_p,
+			CLK_SET_RATE_PARENT,
 			RK3368_CLKSEL_CON(53), 8, 2, MFLAGS,
 			RK3368_CLKGATE_CON(5), 15, GFLAGS),
 
-- 
1.9.1
