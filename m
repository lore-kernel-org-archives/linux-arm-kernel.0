From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 11:42:17 -0700
Subject: [PATCH 2/2] clk: rockchip: fix incorrect parent for rk3399's {c,
 g}pll_aclk_perihp_src
In-Reply-To: <1463164937-91089-1-git-send-email-briannorris@chromium.org>
References: <1463164937-91089-1-git-send-email-briannorris@chromium.org>
Message-ID: <1463164937-91089-2-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xing Zheng <zhengxing@rock-chips.com>

There was a typo, swapping 'c' <--> 'g'.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/clk/rockchip/clk-rk3399.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 145756c4f3c8..9f86bfef70f7 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -832,9 +832,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(13), 1, GFLAGS),
 
 	/* perihp */
-	GATE(0, "cpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(5), 0, GFLAGS),
-	GATE(0, "gpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(5), 1, GFLAGS),
 	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(14), 7, 1, MFLAGS, 0, 5, DFLAGS,
-- 
2.8.0.rc3.226.g39d4020
