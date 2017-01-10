From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Tue, 10 Jan 2017 19:59:20 +0800
Subject: [PATCH 4/4] clk: rockchip: add rk3288 cif_out clock
In-Reply-To: <1484049560-14820-1-git-send-email-jacob-chen@iotwrt.com>
References: <1484049560-14820-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1484049560-14820-4-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clocks for the cif block of the rk3288

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 8047cea..f071c24 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -192,6 +192,7 @@ PNAME(mux_uart1_p)	= { "uart1_src", "uart1_frac", "xin24m" };
 PNAME(mux_uart2_p)	= { "uart2_src", "uart2_frac", "xin24m" };
 PNAME(mux_uart3_p)	= { "uart3_src", "uart3_frac", "xin24m" };
 PNAME(mux_uart4_p)	= { "uart4_src", "uart4_frac", "xin24m" };
+PNAME(mux_cif_out_p)	= { "cif_src", "xin24m" };
 PNAME(mux_vip_out_p)	= { "vip_src", "xin24m" };
 PNAME(mux_mac_p)	= { "mac_pll_src", "ext_gmac" };
 PNAME(mux_hsadcout_p)	= { "hsadc_src", "ext_hsadc" };
@@ -448,6 +449,12 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 			RK3288_CLKSEL_CON(6), 14, 2, MFLAGS, 8, 6, DFLAGS,
 			RK3288_CLKGATE_CON(3), 15, GFLAGS),
 
+	COMPOSITE_NOGATE(0, "cif_src", mux_pll_src_cpll_gpll_p, 0,
+			RK3288_CLKSEL_CON(26), 8, 1, MFLAGS, 9, 5, DFLAGS),
+	COMPOSITE_NODIV(SCLK_CIF_OUT, "sclk_cif_out", mux_cif_out_p, 0,
+			RK3288_CLKSEL_CON(26), 15, 1, MFLAGS,
+			RK3288_CLKGATE_CON(3), 7, GFLAGS),
+
 	GATE(SCLK_HDMI_HDCP, "sclk_hdmi_hdcp", "xin24m", 0,
 			RK3288_CLKGATE_CON(5), 12, GFLAGS),
 	GATE(SCLK_HDMI_CEC, "sclk_hdmi_cec", "xin32k", 0,
-- 
2.7.4
