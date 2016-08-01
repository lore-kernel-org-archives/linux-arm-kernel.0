From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon,  1 Aug 2016 12:23:06 +0800
Subject: [RESEND PATCH 3/6] clk: rockchip: rk3399: fix incorrect aclk_emmc
 source gate bits
In-Reply-To: <1470025389-4094-1-git-send-email-zhengxing@rock-chips.com>
References: <1470025389-4094-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1470025389-4094-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dues to incorrect diagram, we need to fix incorrect bits for
(c/g)pll_aclk_emmc_src:
cpll_aclk_emmc_src --> G6[13]
gpll_aclk_emmc_src --> G6[12]

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index f55f967f..ad3860a 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -923,9 +923,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(6), 14, GFLAGS),
 
 	GATE(0, "cpll_aclk_emmc_src", "cpll", CLK_IGNORE_UNUSED,
-			RK3399_CLKGATE_CON(6), 12, GFLAGS),
-	GATE(0, "gpll_aclk_emmc_src", "gpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(6), 13, GFLAGS),
+	GATE(0, "gpll_aclk_emmc_src", "gpll", CLK_IGNORE_UNUSED,
+			RK3399_CLKGATE_CON(6), 12, GFLAGS),
 	COMPOSITE_NOGATE(ACLK_EMMC, "aclk_emmc", mux_aclk_emmc_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(21), 7, 1, MFLAGS, 0, 5, DFLAGS),
 	GATE(ACLK_EMMC_CORE, "aclk_emmccore", "aclk_emmc", CLK_IGNORE_UNUSED,
-- 
1.7.9.5
