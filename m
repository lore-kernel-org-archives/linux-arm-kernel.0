From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 30 Jun 2016 10:18:59 +0800
Subject: [PATCH] clk: rockchip: fix the rk3399 spdif incorrect bit for DPTX
Message-ID: <1467253139-21112-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLKSEL_CON32 bit_0 is controlled for spdif_8ch, not spdif_rec_dptx,
it should be bit_8, let's fix it.

Reported-by: Chris Zhong <zyw@rock-chips.com>
Tested-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index b6742fa..78e51cb 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -586,7 +586,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(8), 15, GFLAGS),
 
 	COMPOSITE(SCLK_SPDIF_REC_DPTX, "clk_spdif_rec_dptx", mux_pll_src_cpll_gpll_p, 0,
-			RK3399_CLKSEL_CON(32), 15, 1, MFLAGS, 0, 5, DFLAGS,
+			RK3399_CLKSEL_CON(32), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(10), 6, GFLAGS),
 	/* i2s */
 	COMPOSITE(0, "clk_i2s0_div", mux_pll_src_cpll_gpll_p, 0,
-- 
1.7.9.5
