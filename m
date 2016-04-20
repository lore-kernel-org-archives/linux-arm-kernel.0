From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 20 Apr 2016 19:06:52 +0800
Subject: [PATCH 4/6] clk: rockchip: rk3399: update necessary critical clocks
In-Reply-To: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
References: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1461150414-29638-5-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to declare that we enable all NOCs which are critical
clocks always and clearly and explicitly show that we have enabled
them at clk_summary.

We need to add some has been verified and required critical clocks
in the development process.

And the pclk_perilp1_noc is also add CLK_IGNORE_UNUSED flag.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c |   72 +++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 232ea68..1da4fe1 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1043,7 +1043,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(PCLK_SPI2, "pclk_spi2", "pclk_perilp1", 0, RK3399_CLKGATE_CON(23), 12, GFLAGS),
 	GATE(PCLK_SPI4, "pclk_spi4", "pclk_perilp1", 0, RK3399_CLKGATE_CON(23), 13, GFLAGS),
 	GATE(PCLK_PERIHP_GRF, "pclk_perilp_sgrf", "pclk_perilp1", 0, RK3399_CLKGATE_CON(24), 13, GFLAGS),
-	GATE(0, "pclk_perilp1_noc", "pclk_perilp1", 0, RK3399_CLKGATE_CON(25), 10, GFLAGS),
+	GATE(0, "pclk_perilp1_noc", "pclk_perilp1", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 10, GFLAGS),
 
 	/* saradc */
 	COMPOSITE_NOMUX(SCLK_SARADC, "clk_saradc", "xin24m", 0,
@@ -1464,33 +1464,85 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 };
 
 static const char *const rk3399_cru_critical_clocks[] __initconst = {
-	"aclk_cci_pre",
+	/*
+	 * We need to declare that we enable all NOCs which are critical clocks
+	 * always and clearly and explicitly show that we have enabled them at
+	 * clk_summary.
+	 */
+	"aclk_usb3_noc",
+	"aclk_gmac_noc",
+	"pclk_gmac_noc",
+	"pclk_center_main_noc",
+	"aclk_cci_noc0",
+	"aclk_cci_noc1",
+	"clk_dbg_noc",
+	"hclk_vcodec_noc",
+	"aclk_vcodec_noc",
+	"hclk_vdu_noc",
+	"aclk_vdu_noc",
+	"hclk_iep_noc",
+	"aclk_iep_noc",
+	"hclk_rga_noc",
+	"aclk_rga_noc",
+	"aclk_center_main_noc",
+	"aclk_center_peri_noc",
+	"aclk_perihp_noc",
+	"hclk_perihp_noc",
+	"pclk_perihp_noc",
+	"hclk_sdmmc_noc",
+	"aclk_emmc_noc",
+	"aclk_perilp0_noc",
+	"hclk_perilp0_noc",
+	"hclk_m0_perilp_noc",
+	"hclk_perilp1_noc",
+	"hclk_sdio_noc",
+	"hclk_sdioaudio_noc",
+	"pclk_perilp1_noc",
+	"aclk_vio_noc",
+	"aclk_hdcp_noc",
+	"hclk_hdcp_noc",
+	"pclk_hdcp_noc",
+	"pclk_edp_noc",
+	"aclk_vop0_noc",
+	"hclk_vop0_noc",
+	"aclk_vop1_noc",
+	"hclk_vop1_noc",
+	"aclk_isp0_noc",
+	"hclk_isp0_noc",
+	"aclk_isp1_noc",
+	"hclk_isp1_noc",
+	"aclk_gic_noc",
+
+	/* other critical clocks */
 	"pclk_perilp0",
 	"pclk_perilp0",
 	"hclk_perilp0",
-	"hclk_perilp0_noc",
 	"pclk_perilp1",
-	"pclk_perilp1_noc",
 	"pclk_perihp",
-	"pclk_perihp_noc",
 	"hclk_perihp",
 	"aclk_perihp",
-	"aclk_perihp_noc",
 	"aclk_perilp0",
-	"aclk_perilp0_noc",
 	"hclk_perilp1",
-	"hclk_perilp1_noc",
-	"aclk_dmac0_perilp",
-	"gpll_hclk_perilp1_src",
+	"aclk_dmac1_perilp",
 	"gpll_aclk_perilp0_src",
 	"gpll_aclk_perihp_src",
 };
 
 static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
+	/*
+	 * We need to declare that we enable all NOCs which are critical clocks
+	 * always and clearly and explicitly show that we have enabled them at
+	 * clk_summary.
+	 */
+	"pclk_noc_pmu",
+	"hclk_noc_pmu",
+
+	/* other critical clocks */
 	"ppll",
 	"pclk_pmu_src",
 	"fclk_cm0s_src_pmu",
 	"clk_timer_src_pmu",
+	"pclk_rkpwm_pmu",
 };
 
 static void __init rk3399_clk_init(struct device_node *np)
-- 
1.7.9.5
