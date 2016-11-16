From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 16 Nov 2016 08:07:15 +0800
Subject: [PATCH] clk: rockchip: rk3399: fix copy-paste error
Message-ID: <1479254835-6858-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix RK3368_CLKSEL_CON to RK3399_CLKSEL_CON for rk3399 clock
driver.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3399.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 2c7cba7..2bde6cd 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1382,8 +1382,8 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	/* clk_test */
 	/* clk_test_pre is controlled by CRU_MISC_CON[3] */
 	COMPOSITE_NOMUX(0, "clk_test", "clk_test_pre", CLK_IGNORE_UNUSED,
-			RK3368_CLKSEL_CON(58), 0, 5, DFLAGS,
-			RK3368_CLKGATE_CON(13), 11, GFLAGS),
+			RK3399_CLKSEL_CON(58), 0, 5, DFLAGS,
+			RK3399_CLKSEL_CON(13), 11, GFLAGS),
 
 	/* ddrc */
 	GATE(0, "clk_ddrc_lpll_src", "lpll", 0, RK3399_CLKGATE_CON(3),
-- 
1.9.1
