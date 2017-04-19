From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Wed, 19 Apr 2017 15:30:23 +0800
Subject: [PATCH 2/2] clk: rockchip: fix the incorrect id for clk_testout1
In-Reply-To: <20170419073023.1921-1-eddie.cai.linux@gmail.com>
References: <20170419073023.1921-1-eddie.cai.linux@gmail.com>
Message-ID: <20170419073023.1921-3-eddie.cai.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the id for clk_testout1 is wrong, so correct it.

Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
---
 drivers/clk/rockchip/clk-rk3399.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 73121b14..322611d 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1066,7 +1066,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	/* cif_testout */
 	MUX(0, "clk_testout1_pll_src", mux_pll_src_cpll_gpll_npll_p, 0,
 			RK3399_CLKSEL_CON(38), 6, 2, MFLAGS),
-	COMPOSITE(0, "clk_testout1", mux_clk_testout1_p, 0,
+	COMPOSITE(SCLK_TESTCLKOUT1, "clk_testout1", mux_clk_testout1_p, 0,
 			RK3399_CLKSEL_CON(38), 5, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(13), 14, GFLAGS),
 
-- 
2.10.2
