From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 4 Aug 2014 17:45:37 +0800
Subject: [PATCH] clk: ppc-corenet: Add Freescale ARM-based platforms
 CLK_OF_DECLARE support
Message-ID: <1407145537-15027-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/clk/Kconfig           | 7 ++++---
 drivers/clk/clk-ppc-corenet.c | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index cfd3af7..8784704 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -82,11 +82,12 @@ config COMMON_CLK_AXI_CLKGEN
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
 
 config CLK_PPC_CORENET
-	bool "Clock driver for PowerPC corenet platforms"
-	depends on PPC_E500MC && OF
+	bool "Clock driver for PowerPC corenet and compatible ARM-based platforms"
+	depends on (PPC_E500MC || ARM) && OF
 	---help---
 	  This adds the clock driver support for Freescale PowerPC corenet
-	  platforms using common clock framework.
+	  platforms and compatible Freescale ARM based platforms using common
+	  clock framework.
 
 config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 8e58edf..7692cac 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -305,3 +305,8 @@ static int __init ppc_corenet_clk_init(void)
 	return platform_driver_register(&ppc_corenet_clk_driver);
 }
 subsys_initcall(ppc_corenet_clk_init);
+
+CLK_OF_DECLARE(ppc_core_pll_v1, "fsl,qoriq-core-pll-1.0", core_pll_init);
+CLK_OF_DECLARE(ppc_core_pll_v2, "fsl,qoriq-core-pll-2.0", core_pll_init);
+CLK_OF_DECLARE(ppc_core_mux_v1, "fsl,qoriq-core-mux-1.0", core_mux_init);
+CLK_OF_DECLARE(ppc_core_mux_v2, "fsl,qoriq-core-mux-2.0", core_mux_init);
-- 
1.8.0
