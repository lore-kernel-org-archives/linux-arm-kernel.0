From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  7 Jan 2016 16:25:47 +0800
Subject: [PATCH v2 04/12] clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED
 flag for sclk_i2s_out
In-Reply-To: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452155155-16232-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCLk_I2S_OUT is the noc bus clock for i2s module, this clock is used by
extra codecs.

Due to it shouldn't belong to any driver, but we need it enabled,
so just mark it as the CLK_IGNORE_UNUSED flag.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None

 drivers/clk/rockchip/clk-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 34c78f4..c33ed3c 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -310,7 +310,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(7), 0,
 			RK2928_CLKGATE_CON(0), 10, GFLAGS,
 			&rk3036_i2s_fracmux),
-	COMPOSITE_NODIV(SCLK_I2S_OUT, "i2s_clkout", mux_i2s_clkout_p, 0,
+	COMPOSITE_NODIV(SCLK_I2S_OUT, "i2s_clkout", mux_i2s_clkout_p, CLK_IGNORE_UNUSED,
 			RK2928_CLKSEL_CON(3), 12, 1, MFLAGS,
 			RK2928_CLKGATE_CON(0), 13, GFLAGS),
 	GATE(SCLK_I2S, "sclk_i2s", "i2s_pre", CLK_SET_RATE_PARENT,
-- 
1.9.1
