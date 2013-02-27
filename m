From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:48 +0800
Subject: [PATCH 12/12] ARM: dts: remove mxs-dma channel interrupt number from
 client nodes
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With adopting generic DMA device tree binding, all mxs-dma channel
interrupt numbers are defined in DMA controller nodes, so they can be
removed from client nodes.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi   |   12 ++++++------
 arch/arm/boot/dts/imx28.dtsi   |   36 ++++++++++++++++++------------------
 arch/arm/boot/dts/imx6qdl.dtsi |    4 ++--
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 889a89a..1d5b0ac 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -72,8 +72,8 @@
 				#size-cells = <1>;
 				reg = <0x8000c000 0x2000>, <0x8000a000 0x2000>;
 				reg-names = "gpmi-nand", "bch";
-				interrupts = <13>, <56>;
-				interrupt-names = "gpmi-dma", "bch";
+				interrupts = <56>;
+				interrupt-names = "bch";
 				clocks = <&clks 34>;
 				clock-names = "gpmi_io";
 				dmas = <&dma_apbh 4>;
@@ -84,7 +84,7 @@
 
 			ssp0: ssp at 80010000 {
 				reg = <0x80010000 0x2000>;
-				interrupts = <15 14>;
+				interrupts = <15>;
 				clocks = <&clks 33>;
 				dmas = <&dma_apbh 1>;
 				dma-names = "ssp";
@@ -360,7 +360,7 @@
 
 			ssp1: ssp at 80034000 {
 				reg = <0x80034000 0x2000>;
-				interrupts = <2 20>;
+				interrupts = <2>;
 				clocks = <&clks 33>;
 				dmas = <&dma_apbh 2>;
 				dma-names = "ssp";
@@ -465,7 +465,7 @@
 			auart0: serial at 8006c000 {
 				compatible = "fsl,imx23-auart";
 				reg = <0x8006c000 0x2000>;
-				interrupts = <24 25 23>;
+				interrupts = <24>;
 				clocks = <&clks 32>;
 				dmas = <&dma_apbx 6>, <&dma_apbx 7>;
 				dma-names = "rx", "tx";
@@ -475,7 +475,7 @@
 			auart1: serial at 8006e000 {
 				compatible = "fsl,imx23-auart";
 				reg = <0x8006e000 0x2000>;
-				interrupts = <59 60 58>;
+				interrupts = <59>;
 				clocks = <&clks 32>;
 				dmas = <&dma_apbx 8>, <&dma_apbx 9>;
 				dma-names = "rx", "tx";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index bb63d4e..79af54e 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -60,7 +60,7 @@
 
 			hsadc at 80002000 {
 				reg = <0x80002000 0x2000>;
-				interrupts = <13 87>;
+				interrupts = <13>;
 				dmas = <&dma_apbh 12>;
 				dma-names = "hsadc";
 				status = "disabled";
@@ -94,8 +94,8 @@
 				#size-cells = <1>;
 				reg = <0x8000c000 0x2000>, <0x8000a000 0x2000>;
 				reg-names = "gpmi-nand", "bch";
-				interrupts = <88>, <41>;
-				interrupt-names = "gpmi-dma", "bch";
+				interrupts = <41>;
+				interrupt-names = "bch";
 				clocks = <&clks 50>;
 				clock-names = "gpmi_io";
 				dmas = <&dma_apbh 4>;
@@ -108,7 +108,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80010000 0x2000>;
-				interrupts = <96 82>;
+				interrupts = <96>;
 				clocks = <&clks 46>;
 				dmas = <&dma_apbh 0>;
 				dma-names = "ssp";
@@ -120,7 +120,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80012000 0x2000>;
-				interrupts = <97 83>;
+				interrupts = <97>;
 				clocks = <&clks 47>;
 				dmas = <&dma_apbh 1>;
 				dma-names = "ssp";
@@ -132,7 +132,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80014000 0x2000>;
-				interrupts = <98 84>;
+				interrupts = <98>;
 				clocks = <&clks 48>;
 				dmas = <&dma_apbh 2>;
 				dma-names = "ssp";
@@ -144,7 +144,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80016000 0x2000>;
-				interrupts = <99 85>;
+				interrupts = <99>;
 				clocks = <&clks 49>;
 				dmas = <&dma_apbh 3>;
 				dma-names = "ssp";
@@ -720,7 +720,7 @@
 			lcdif at 80030000 {
 				compatible = "fsl,imx28-lcdif";
 				reg = <0x80030000 0x2000>;
-				interrupts = <38 86>;
+				interrupts = <38>;
 				clocks = <&clks 55>;
 				dmas = <&dma_apbh 13>;
 				dma-names = "lcdif";
@@ -797,7 +797,7 @@
 			saif0: saif at 80042000 {
 				compatible = "fsl,imx28-saif";
 				reg = <0x80042000 0x2000>;
-				interrupts = <59 80>;
+				interrupts = <59>;
 				clocks = <&clks 53>;
 				dmas = <&dma_apbx 4>;
 				dma-names = "saif";
@@ -813,7 +813,7 @@
 			saif1: saif at 80046000 {
 				compatible = "fsl,imx28-saif";
 				reg = <0x80046000 0x2000>;
-				interrupts = <58 81>;
+				interrupts = <58>;
 				clocks = <&clks 54>;
 				dmas = <&dma_apbx 5>;
 				dma-names = "saif";
@@ -831,7 +831,7 @@
 
 			spdif at 80054000 {
 				reg = <0x80054000 0x2000>;
-				interrupts = <45 66>;
+				interrupts = <45>;
 				dmas = <&dma_apbx 2>;
 				dma-names = "spdif";
 				status = "disabled";
@@ -848,7 +848,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 0x2000>;
-				interrupts = <111 68>;
+				interrupts = <111>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 6>;
 				dma-names = "i2c";
@@ -861,7 +861,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 0x2000>;
-				interrupts = <110 69>;
+				interrupts = <110>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 7>;
 				dma-names = "i2c";
@@ -887,7 +887,7 @@
 			auart0: serial at 8006a000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
-				interrupts = <112 70 71>;
+				interrupts = <112>;
 				dmas = <&dma_apbx 8>, <&dma_apbx 9>;
 				dma-names = "rx", "tx";
 				fsl,auart-dma-channel = <8 9>;
@@ -898,7 +898,7 @@
 			auart1: serial at 8006c000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006c000 0x2000>;
-				interrupts = <113 72 73>;
+				interrupts = <113>;
 				dmas = <&dma_apbx 10>, <&dma_apbx 11>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
@@ -908,7 +908,7 @@
 			auart2: serial at 8006e000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006e000 0x2000>;
-				interrupts = <114 74 75>;
+				interrupts = <114>;
 				dmas = <&dma_apbx 12>, <&dma_apbx 13>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
@@ -918,7 +918,7 @@
 			auart3: serial at 80070000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80070000 0x2000>;
-				interrupts = <115 76 77>;
+				interrupts = <115>;
 				dmas = <&dma_apbx 14>, <&dma_apbx 15>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
@@ -928,7 +928,7 @@
 			auart4: serial at 80072000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80072000 0x2000>;
-				interrupts = <116 78 79>;
+				interrupts = <116>;
 				dmas = <&dma_apbx 0>, <&dma_apbx 1>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ccdcb06..8abf2dc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -81,8 +81,8 @@
 			#size-cells = <1>;
 			reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
 			reg-names = "gpmi-nand", "bch";
-			interrupts = <0 13 0x04>, <0 15 0x04>;
-			interrupt-names = "gpmi-dma", "bch";
+			interrupts = <0 15 0x04>;
+			interrupt-names = "bch";
 			clocks = <&clks 152>, <&clks 153>, <&clks 151>,
 				 <&clks 150>, <&clks 149>;
 			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
-- 
1.7.9.5
