From: zhangqing@rock-chips.com (Zhang Qing)
Date: Mon, 25 Jan 2016 08:56:01 -0800
Subject: [PATCH v1 2/3] clk: rockchip: rk3368: enable the CLK_SET_RATE_PARENT
 flag for spdif_8ch
In-Reply-To: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
References: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1453740962-8556-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhangqing <zhangqing@rock-chips.com>

SPDIF_8CH set freq need to select parent and calculate parent freq.
so just mark it as the CLK_SET_RATE_PARENT flag.

Signed-off-by: zhangqing <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 4885e6b..58ef08b 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -353,7 +353,8 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	COMPOSITE_FRAC(0, "spdif_8ch_frac", "spdif_8ch_src", CLK_SET_RATE_PARENT,
 			RK3368_CLKSEL_CON(32), 0,
 			RK3368_CLKGATE_CON(6), 5, GFLAGS),
-	COMPOSITE_NODIV(SCLK_SPDIF_8CH, "sclk_spdif_8ch", mux_spdif_8ch_p, 0,
+	COMPOSITE_NODIV(SCLK_SPDIF_8CH, "sclk_spdif_8ch", mux_spdif_8ch_p,
+			CLK_SET_RATE_PARENT,
 			RK3368_CLKSEL_CON(31), 8, 2, MFLAGS,
 			RK3368_CLKGATE_CON(6), 6, GFLAGS),
 	COMPOSITE(0, "i2s_2ch_src", mux_pll_src_cpll_gpll_p, 0,
-- 
1.9.1
