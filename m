From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:18 +0800
Subject: [PATCH 7/7] ARM: dts: imx6: add mmdc ipg clock
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535701998-20443-8-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6 SoCs has MMDC clock gates in CCM CCGR, add
clock property for MMDC driver's clock operation.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sll.dtsi | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 61d2d26..5d33729 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1115,6 +1115,7 @@
 			mmdc0: mmdc at 21b0000 { /* MMDC0 */
 				compatible = "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
 			};
 
 			mmdc1: mmdc at 21b4000 { /* MMDC1 */
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 7a4f5da..63a18e1 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -921,6 +921,7 @@
 			mmdc: mmdc at 21b0000 {
 				compatible = "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6SL_CLK_MMDC_P0_IPG>;
 			};
 
 			rngb: rngb at 21b4000 {
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index ed9a980..e462f76 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -770,6 +770,7 @@
 			mmdc: memory-controller at 21b0000 {
 				compatible = "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6SLL_CLK_MMDC_P0_IPG>;
 			};
 
 			ocotp: ocotp-ctrl at 21bc000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 844caa3..ba4ab79 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1002,6 +1002,7 @@
 			mmdc: mmdc at 21b0000 {
 				compatible = "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6SX_CLK_MMDC_P0_IPG>;
 			};
 
 			fec2: ethernet at 21b4000 {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 448d765..2019ad5 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -916,6 +916,7 @@
 			mmdc: mmdc at 21b0000 {
 				compatible = "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6UL_CLK_MMDC_P0_IPG>;
 			};
 
 			weim: weim at 21b8000 {
-- 
2.7.4
