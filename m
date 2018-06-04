From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Mon,  4 Jun 2018 12:00:35 +0200
Subject: [PATCH v5 4/4] ARM: dts: imx: add missing compatible and clock
 properties for EPIT
In-Reply-To: <20180604100035.19558-1-peron.clem@gmail.com>
References: <20180604100035.19558-1-peron.clem@gmail.com>
Message-ID: <20180604100035.19558-5-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Didier <colin.didier@devialet.com>

Add missing compatible and clock properties for EPIT node.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
---
 arch/arm/boot/dts/imx25.dtsi   |  8 ++++++--
 arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++--
 arch/arm/boot/dts/imx6sl.dtsi  | 14 ++++++++++----
 arch/arm/boot/dts/imx6sx.dtsi  | 10 ++++++++--
 arch/arm/boot/dts/imx6ul.dtsi  | 10 ++++++++--
 5 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index cf70df20b19c..15fd4308dad8 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -396,15 +396,19 @@
 			};
 
 			epit1: timer at 53f94000 {
-				compatible = "fsl,imx25-epit";
+				compatible = "fsl,imx25-epit", "fsl,imx31-epit";
 				reg = <0x53f94000 0x4000>;
 				interrupts = <28>;
+				clocks = <&clks 83>;
+				status = "disabled";
 			};
 
 			epit2: timer at 53f98000 {
-				compatible = "fsl,imx25-epit";
+				compatible = "fsl,imx25-epit", "fsl,imx31-epit";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <27>;
+				clocks = <&clks 84>;
+				status = "disabled";
 			};
 
 			gpio4: gpio at 53f9c000 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62bf290..65c4ee07454c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -843,14 +843,20 @@
 				};
 			};
 
-			epit1: epit at 20d0000 { /* EPIT1 */
+			epit1: timer at 20d0000 {
+				compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit at 20d4000 { /* EPIT2 */
+			epit2: timer at 20d4000 {
+				compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src at 20d8000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ab6a7e2e7e8f..6229bbef7ccc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -671,14 +671,20 @@
 				};
 			};
 
-			epit1: epit at 20d0000 {
+			epit1: timer at 20d0000 {
+				compatible = "fsl,imx6sl-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
-				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit at 20d4000 {
+			epit2: timer at 20d4000 {
+				compatible = "fsl,imx6sl-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
-				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src at 20d8000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205b8db8..2b30559d3270 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -736,14 +736,20 @@
 				};
 			};
 
-			epit1: epit at 20d0000 {
+			epit1: timer at 20d0000 {
+				compatible = "fsl,imx6sx-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SX_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit at 20d4000 {
+			epit2: timer at 20d4000 {
+				compatible = "fsl,imx6sx-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SX_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src at 20d8000 {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972b16ba..d5f765da1ee2 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -658,14 +658,20 @@
 				};
 			};
 
-			epit1: epit at 20d0000 {
+			epit1: timer at 20d0000 {
+				compatible = "fsl,imx6ul-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit at 20d4000 {
+			epit2: timer at 20d4000 {
+				compatible = "fsl,imx6ul-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src at 20d8000 {
-- 
2.17.0
