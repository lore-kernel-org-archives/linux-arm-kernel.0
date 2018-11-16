From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 16 Nov 2018 16:49:25 +0100
Subject: [PATCH 1/3] soc: imx: gpcv2: prefix i.MX7 specific defines
Message-ID: <20181116154927.16152-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So we can add i.MX8M support without introducing name clashes.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 56 ++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index e7b5994fee9d..4183f7f830c8 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -18,19 +18,19 @@
 #define GPC_LPCR_A_CORE_BSC			0x000
 
 #define GPC_PGC_CPU_MAPPING		0x0ec
-#define USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
-#define USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
-#define USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
-#define PCIE_PHY_A_CORE_DOMAIN		BIT(3)
-#define MIPI_PHY_A_CORE_DOMAIN		BIT(2)
+#define IMX7_USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
+#define IMX7_USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
+#define IMX7_USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
+#define IMX7_PCIE_PHY_A_CORE_DOMAIN		BIT(3)
+#define IMX7_MIPI_PHY_A_CORE_DOMAIN		BIT(2)
 
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
-#define USB_HSIC_PHY_SW_Pxx_REQ		BIT(4)
-#define USB_OTG2_PHY_SW_Pxx_REQ		BIT(3)
-#define USB_OTG1_PHY_SW_Pxx_REQ		BIT(2)
-#define PCIE_PHY_SW_Pxx_REQ		BIT(1)
-#define MIPI_PHY_SW_Pxx_REQ		BIT(0)
+#define IMX7_USB_HSIC_PHY_SW_Pxx_REQ		BIT(4)
+#define IMX7_USB_OTG2_PHY_SW_Pxx_REQ		BIT(3)
+#define IMX7_USB_OTG1_PHY_SW_Pxx_REQ		BIT(2)
+#define IMX7_PCIE_PHY_SW_Pxx_REQ		BIT(1)
+#define IMX7_MIPI_PHY_SW_Pxx_REQ		BIT(0)
 
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
@@ -40,9 +40,9 @@
  * GPC_PGC memory map are incorrect, below offset
  * values are from design RTL.
  */
-#define PGC_MIPI			16
-#define PGC_PCIE			17
-#define PGC_USB_HSIC			20
+#define IMX7_PGC_MIPI			16
+#define IMX7_PGC_PCIE			17
+#define IMX7_PGC_USB_HSIC		20
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -166,11 +166,11 @@ static const struct imx_pgc_domain imx7_pgc_domains[] = {
 			.name      = "mipi-phy",
 		},
 		.bits  = {
-			.pxx = MIPI_PHY_SW_Pxx_REQ,
-			.map = MIPI_PHY_A_CORE_DOMAIN,
+			.pxx = IMX7_MIPI_PHY_SW_Pxx_REQ,
+			.map = IMX7_MIPI_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1000000,
-		.pgc	   = PGC_MIPI,
+		.pgc	   = IMX7_PGC_MIPI,
 	},
 
 	[IMX7_POWER_DOMAIN_PCIE_PHY] = {
@@ -178,11 +178,11 @@ static const struct imx_pgc_domain imx7_pgc_domains[] = {
 			.name      = "pcie-phy",
 		},
 		.bits  = {
-			.pxx = PCIE_PHY_SW_Pxx_REQ,
-			.map = PCIE_PHY_A_CORE_DOMAIN,
+			.pxx = IMX7_PCIE_PHY_SW_Pxx_REQ,
+			.map = IMX7_PCIE_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1000000,
-		.pgc	   = PGC_PCIE,
+		.pgc	   = IMX7_PGC_PCIE,
 	},
 
 	[IMX7_POWER_DOMAIN_USB_HSIC_PHY] = {
@@ -190,11 +190,11 @@ static const struct imx_pgc_domain imx7_pgc_domains[] = {
 			.name      = "usb-hsic-phy",
 		},
 		.bits  = {
-			.pxx = USB_HSIC_PHY_SW_Pxx_REQ,
-			.map = USB_HSIC_PHY_A_CORE_DOMAIN,
+			.pxx = IMX7_USB_HSIC_PHY_SW_Pxx_REQ,
+			.map = IMX7_USB_HSIC_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1200000,
-		.pgc	   = PGC_USB_HSIC,
+		.pgc	   = IMX7_PGC_USB_HSIC,
 	},
 };
 
@@ -269,12 +269,12 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 	static const struct regmap_range yes_ranges[] = {
 		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
 				 GPC_M4_PU_PDN_FLG),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
-				 GPC_PGC_SR(PGC_MIPI)),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_PCIE),
-				 GPC_PGC_SR(PGC_PCIE)),
-		regmap_reg_range(GPC_PGC_CTRL(PGC_USB_HSIC),
-				 GPC_PGC_SR(PGC_USB_HSIC)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_MIPI),
+				 GPC_PGC_SR(IMX7_PGC_MIPI)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_PCIE),
+				 GPC_PGC_SR(IMX7_PGC_PCIE)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX7_PGC_USB_HSIC),
+				 GPC_PGC_SR(IMX7_PGC_USB_HSIC)),
 	};
 	static const struct regmap_access_table access_table = {
 		.yes_ranges	= yes_ranges,
-- 
2.19.1
