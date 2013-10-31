From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 31 Oct 2013 14:32:06 +0800
Subject: [PATCH v2 4/4] ARM: dts: imx: use dual-fifo sdma script for ssi
In-Reply-To: <cover.1383197521.git.b42378@freescale.com>
References: <cover.1383197521.git.b42378@freescale.com>
Message-ID: <188758e053a4ffb873e48b2c5003f0f0334fa1fc.1383197521.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dual-fifo sdma scripts instead of shared scripts for ssi on i.MX series.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx51.dtsi   |  4 ++--
 arch/arm/boot/dts/imx53.dtsi   |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++++------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 54cee65..1a71eac 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -154,8 +154,8 @@
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
-					dmas = <&sdma 24 1 0>,
-					       <&sdma 25 1 0>;
+					dmas = <&sdma 24 22 0>,
+					       <&sdma 25 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..7208fde 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -153,8 +153,8 @@
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
-					dmas = <&sdma 24 1 0>,
-					       <&sdma 25 1 0>;
+					dmas = <&sdma 24 22 0>,
+					       <&sdma 25 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 57e9c38..6e096ca 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -223,8 +223,8 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks 178>;
-					dmas = <&sdma 37 1 0>,
-					       <&sdma 38 1 0>;
+					dmas = <&sdma 37 22 0>,
+					       <&sdma 38 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <38 37>;
@@ -236,8 +236,8 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks 179>;
-					dmas = <&sdma 41 1 0>,
-					       <&sdma 42 1 0>;
+					dmas = <&sdma 41 22 0>,
+					       <&sdma 42 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <42 41>;
@@ -249,8 +249,8 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks 180>;
-					dmas = <&sdma 45 1 0>,
-					       <&sdma 46 1 0>;
+					dmas = <&sdma 45 22 0>,
+					       <&sdma 46 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <46 45>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..b32ba99 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -195,8 +195,8 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
-					dmas = <&sdma 37 1 0>,
-					       <&sdma 38 1 0>;
+					dmas = <&sdma 37 22 0>,
+					       <&sdma 38 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -207,8 +207,8 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
-					dmas = <&sdma 41 1 0>,
-					       <&sdma 42 1 0>;
+					dmas = <&sdma 41 22 0>,
+					       <&sdma 42 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -219,8 +219,8 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
-					dmas = <&sdma 45 1 0>,
-					       <&sdma 46 1 0>;
+					dmas = <&sdma 45 22 0>,
+					       <&sdma 46 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
-- 
1.8.4
