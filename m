From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 24 Feb 2016 18:54:18 +0800
Subject: [PATCH v1 2/4] clk: rockchip: set the clock ids for RK3228 VOP
In-Reply-To: <1456308303-29706-1-git-send-email-ykk@rock-chips.com>
References: <1456308303-29706-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1456311258-4311-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3228.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 981a502..8747b25 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -368,7 +368,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(29), 0, 3, DFLAGS),
 	DIV(0, "sclk_vop_pre", "sclk_vop_src", 0,
 			RK2928_CLKSEL_CON(27), 8, 8, DFLAGS),
-	MUX(0, "dclk_vop", mux_dclk_vop_p, 0,
+	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, 0,
 			RK2928_CLKSEL_CON(27), 1, 1, MFLAGS),
 
 	COMPOSITE(0, "i2s0_src", mux_pll_src_2plls_p, 0,
@@ -503,7 +503,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	GATE(0, "aclk_iep", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 2, GFLAGS),
 	GATE(0, "aclk_iep_noc", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 9, GFLAGS),
 
-	GATE(0, "aclk_vop", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 5, GFLAGS),
+	GATE(ACLK_VOP, "aclk_vop", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 5, GFLAGS),
 	GATE(0, "aclk_vop_noc", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 12, GFLAGS),
 
 	GATE(0, "aclk_hdcp", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(14), 10, GFLAGS),
@@ -511,7 +511,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 
 	GATE(0, "hclk_rga", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(0, "hclk_iep", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 3, GFLAGS),
-	GATE(0, "hclk_vop", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 6, GFLAGS),
+	GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(0, "hclk_vio_ahb_arbi", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 7, GFLAGS),
 	GATE(0, "hclk_vio_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 8, GFLAGS),
 	GATE(0, "hclk_vop_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 13, GFLAGS),
-- 
1.9.1
