From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Jun 2015 18:22:16 +0200
Subject: [PATCH 2/8] clk: rockchip: fix faulty vip parent name on rk3288
In-Reply-To: <1434212542-17145-1-git-send-email-heiko@sntech.de>
References: <1434212542-17145-1-git-send-email-heiko@sntech.de>
Message-ID: <1434212542-17145-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The video input processor (vip) was called camera interface (cif) on
older socs which seems to have resulted in a copy'n'paste error when
creating the rk3288 camera clocks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3288.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 4f817ed..6f0259f 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -189,7 +189,7 @@ PNAME(mux_uart1_p)	= { "uart1_src", "uart1_frac", "xin24m" };
 PNAME(mux_uart2_p)	= { "uart2_src", "uart2_frac", "xin24m" };
 PNAME(mux_uart3_p)	= { "uart3_src", "uart3_frac", "xin24m" };
 PNAME(mux_uart4_p)	= { "uart4_src", "uart4_frac", "xin24m" };
-PNAME(mux_cif_out_p)	= { "cif_src", "xin24m" };
+PNAME(mux_vip_out_p)	= { "vip_src", "xin24m" };
 PNAME(mux_mac_p)	= { "mac_pll_src", "ext_gmac" };
 PNAME(mux_hsadcout_p)	= { "hsadc_src", "ext_hsadc" };
 PNAME(mux_edp_24m_p)	= { "ext_edp_24m", "xin24m" };
@@ -434,7 +434,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE_NODIV(0, "vip_src", mux_pll_src_cpll_gpll_p, 0,
 			RK3288_CLKSEL_CON(26), 8, 1, MFLAGS,
 			RK3288_CLKGATE_CON(3), 7, GFLAGS),
-	COMPOSITE_NOGATE(0, "sclk_vip_out", mux_cif_out_p, 0,
+	COMPOSITE_NOGATE(0, "sclk_vip_out", mux_vip_out_p, 0,
 			RK3288_CLKSEL_CON(26), 15, 1, MFLAGS, 9, 5, DFLAGS),
 
 	DIV(0, "pclk_pd_alive", "gpll", 0,
-- 
2.1.4
