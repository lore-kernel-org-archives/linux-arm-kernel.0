From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:17 +0800
Subject: [PATCH 6/7] clk: imx6q: add mmdc0 ipg clock
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535701998-20443-7-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6Q has MMDC0 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c               | 1 +
 include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8c7c2fc..bbe0c60 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -789,6 +789,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);
 	clk[IMX6QDL_CLK_MMDC_CH0_AXI] = imx_clk_gate2_flags("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_MMDC_CH1_AXI] = imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch1_axi_podf", base + 0x74, 22);
+	clk[IMX6QDL_CLK_MMDC_P0_IPG]  = imx_clk_gate2_flags("mmdc_p0_ipg",   "ipg",         base + 0x74, 24, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_OCRAM]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
 	clk[IMX6QDL_CLK_OPENVG_AXI]   = imx_clk_gate2("openvg_axi",    "axi",               base + 0x74, 30);
 	clk[IMX6QDL_CLK_PCIE_AXI]     = imx_clk_gate2("pcie_axi",      "pcie_axi_sel",      base + 0x78, 0);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 7ad171b..87b068f 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -273,6 +273,7 @@
 #define IMX6QDL_CLK_MLB_PODF			260
 #define IMX6QDL_CLK_EPIT1			261
 #define IMX6QDL_CLK_EPIT2			262
-#define IMX6QDL_CLK_END				263
+#define IMX6QDL_CLK_MMDC_P0_IPG			263
+#define IMX6QDL_CLK_END				264
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.7.4
