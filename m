From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Jul 2013 09:45:12 +0800
Subject: [PATCH v2] ARM: dts: imx: use generic DMA bindings for SSI nodes
Message-ID: <1374025512-23437-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates SDMA and SSI nodes to adopt generic DMA bindings.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
 * Include imx6sl.dtsi update

 arch/arm/boot/dts/imx51.dtsi   |   12 +++++++++---
 arch/arm/boot/dts/imx53.dtsi   |   12 +++++++++---
 arch/arm/boot/dts/imx6qdl.dtsi |   12 +++++++++---
 arch/arm/boot/dts/imx6sl.dtsi  |    9 +++++++++
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index d086e07..cca3ef9 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -154,8 +154,10 @@
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
+					dmas = <&sdma 24 1 0>,
+					       <&sdma 25 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
 				};
 
@@ -735,8 +737,10 @@
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks 48>;
+				dmas = <&sdma 28 0 0>,
+				       <&sdma 29 0 0>;
+				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
@@ -784,8 +788,10 @@
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks 50>;
+				dmas = <&sdma 46 0 0>,
+				       <&sdma 47 0 0>;
+				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <47 46 37 35>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 51b93c9..a6b6d95 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -153,8 +153,10 @@
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
+					dmas = <&sdma 24 1 0>,
+					       <&sdma 25 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
 				};
 
@@ -1050,8 +1052,10 @@
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks 48>;
+				dmas = <&sdma 28 0 0>,
+				       <&sdma 29 0 0>;
+				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
@@ -1074,8 +1078,10 @@
 				reg = <0x63fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks 50>;
+				dmas = <&sdma 46 0 0>,
+				       <&sdma 47 0 0>;
+				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <47 46 45 44>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 7c18fa0..d84f8da 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -211,8 +211,10 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks 178>;
+					dmas = <&sdma 37 1 0>,
+					       <&sdma 38 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <38 37>;
 					status = "disabled";
 				};
 
@@ -221,8 +223,10 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks 179>;
+					dmas = <&sdma 41 1 0>,
+					       <&sdma 42 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <42 41>;
 					status = "disabled";
 				};
 
@@ -231,8 +235,10 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks 180>;
+					dmas = <&sdma 45 1 0>,
+					       <&sdma 46 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <46 45>;
 					status = "disabled";
 				};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index d048a78..c46651e 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -195,6 +195,9 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
+					dmas = <&sdma 37 1 0>,
+					       <&sdma 38 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
@@ -204,6 +207,9 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
+					dmas = <&sdma 41 1 0>,
+					       <&sdma 42 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
@@ -213,6 +219,9 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
+					dmas = <&sdma 45 1 0>,
+					       <&sdma 46 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
-- 
1.7.9.5
