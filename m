From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed,  8 Aug 2018 12:39:26 +0800
Subject: [PATCH 1/2] clk: imx: imx7d: remove unnecessary clocks from
 clks_init_on array
Message-ID: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX7D, IMX7D_NAND_USDHC_BUS_ROOT_CLK is NOT necessary
for system, and IMX7D_AHB_CHANNEL_ROOT_CLK is NOT existing
at all, remove them from clks_init_on array.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 881b772..c4518d7 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -381,10 +381,9 @@ static const char *pll_video_bypass_sel[] = { "pll_video_main", "pll_video_main_
 
 static int const clks_init_on[] __initconst = {
 	IMX7D_ARM_A7_ROOT_CLK, IMX7D_MAIN_AXI_ROOT_CLK,
-	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_NAND_USDHC_BUS_ROOT_CLK,
+	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_IPG_ROOT_CLK,
 	IMX7D_DRAM_PHYM_ROOT_CLK, IMX7D_DRAM_ROOT_CLK,
 	IMX7D_DRAM_PHYM_ALT_ROOT_CLK, IMX7D_DRAM_ALT_ROOT_CLK,
-	IMX7D_AHB_CHANNEL_ROOT_CLK, IMX7D_IPG_ROOT_CLK,
 };
 
 static struct clk_onecell_data clk_data;
-- 
2.7.4
