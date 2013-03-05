From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Mar 2013 20:24:04 +0800
Subject: [PATCH v2 12/12] ARM: dts: remove old DMA binding data from client
 nodes
In-Reply-To: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1362486244-24593-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adopting generic DMA device tree binding, now channel interrupt
number is defined in DMA controller node, and channel ID is listed in
"dmas" property.  So the DMA channel interrupt number in client nodes'
"interrupts" property and fsl,<module>-dma-channel which are used by
old customized DMA binding can be removed now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi   |   15 ++++++-------
 arch/arm/boot/dts/imx28.dtsi   |   46 ++++++++++++++++------------------------
 arch/arm/boot/dts/imx6qdl.dtsi |    4 ++--
 3 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 64f901f..c32a651 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -72,23 +72,21 @@
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
 				dma-names = "rx-tx";
-				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
 			ssp0: ssp at 80010000 {
 				reg = <0x80010000 0x2000>;
-				interrupts = <15 14>;
+				interrupts = <15>;
 				clocks = <&clks 33>;
 				dmas = <&dma_apbh 1>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
@@ -360,11 +358,10 @@
 
 			ssp1: ssp at 80034000 {
 				reg = <0x80034000 0x2000>;
-				interrupts = <2 20>;
+				interrupts = <2>;
 				clocks = <&clks 33>;
 				dmas = <&dma_apbh 2>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
@@ -465,7 +462,7 @@
 			auart0: serial at 8006c000 {
 				compatible = "fsl,imx23-auart";
 				reg = <0x8006c000 0x2000>;
-				interrupts = <24 25 23>;
+				interrupts = <24>;
 				clocks = <&clks 32>;
 				dmas = <&dma_apbx 6>, <&dma_apbx 7>;
 				dma-names = "rx", "tx";
@@ -475,7 +472,7 @@
 			auart1: serial at 8006e000 {
 				compatible = "fsl,imx23-auart";
 				reg = <0x8006e000 0x2000>;
-				interrupts = <59 60 58>;
+				interrupts = <59>;
 				clocks = <&clks 32>;
 				dmas = <&dma_apbx 8>, <&dma_apbx 9>;
 				dma-names = "rx", "tx";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 3b87088..b80ce5c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -60,7 +60,7 @@
 
 			hsadc at 80002000 {
 				reg = <0x80002000 0x2000>;
-				interrupts = <13 87>;
+				interrupts = <13>;
 				dmas = <&dma_apbh 12>;
 				dma-names = "rx";
 				status = "disabled";
@@ -94,13 +94,12 @@
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
 				dma-names = "rx-tx";
-				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
@@ -108,11 +107,10 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80010000 0x2000>;
-				interrupts = <96 82>;
+				interrupts = <96>;
 				clocks = <&clks 46>;
 				dmas = <&dma_apbh 0>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <0>;
 				status = "disabled";
 			};
 
@@ -120,11 +118,10 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80012000 0x2000>;
-				interrupts = <97 83>;
+				interrupts = <97>;
 				clocks = <&clks 47>;
 				dmas = <&dma_apbh 1>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
@@ -132,11 +129,10 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80014000 0x2000>;
-				interrupts = <98 84>;
+				interrupts = <98>;
 				clocks = <&clks 48>;
 				dmas = <&dma_apbh 2>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
@@ -144,11 +140,10 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x80016000 0x2000>;
-				interrupts = <99 85>;
+				interrupts = <99>;
 				clocks = <&clks 49>;
 				dmas = <&dma_apbh 3>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <3>;
 				status = "disabled";
 			};
 
@@ -720,7 +715,7 @@
 			lcdif at 80030000 {
 				compatible = "fsl,imx28-lcdif";
 				reg = <0x80030000 0x2000>;
-				interrupts = <38 86>;
+				interrupts = <38>;
 				clocks = <&clks 55>;
 				dmas = <&dma_apbh 13>;
 				dma-names = "rx";
@@ -797,11 +792,10 @@
 			saif0: saif at 80042000 {
 				compatible = "fsl,imx28-saif";
 				reg = <0x80042000 0x2000>;
-				interrupts = <59 80>;
+				interrupts = <59>;
 				clocks = <&clks 53>;
 				dmas = <&dma_apbx 4>;
 				dma-names = "rx-tx";
-				fsl,saif-dma-channel = <4>;
 				status = "disabled";
 			};
 
@@ -813,11 +807,10 @@
 			saif1: saif at 80046000 {
 				compatible = "fsl,imx28-saif";
 				reg = <0x80046000 0x2000>;
-				interrupts = <58 81>;
+				interrupts = <58>;
 				clocks = <&clks 54>;
 				dmas = <&dma_apbx 5>;
 				dma-names = "rx-tx";
-				fsl,saif-dma-channel = <5>;
 				status = "disabled";
 			};
 
@@ -831,7 +824,7 @@
 
 			spdif at 80054000 {
 				reg = <0x80054000 0x2000>;
-				interrupts = <45 66>;
+				interrupts = <45>;
 				dmas = <&dma_apbx 2>;
 				dma-names = "tx";
 				status = "disabled";
@@ -848,11 +841,10 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 0x2000>;
-				interrupts = <111 68>;
+				interrupts = <111>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 6>;
 				dma-names = "rx-tx";
-				fsl,i2c-dma-channel = <6>;
 				status = "disabled";
 			};
 
@@ -861,11 +853,10 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 0x2000>;
-				interrupts = <110 69>;
+				interrupts = <110>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 7>;
 				dma-names = "rx-tx";
-				fsl,i2c-dma-channel = <7>;
 				status = "disabled";
 			};
 
@@ -887,10 +878,9 @@
 			auart0: serial at 8006a000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
-				interrupts = <112 70 71>;
+				interrupts = <112>;
 				dmas = <&dma_apbx 8>, <&dma_apbx 9>;
 				dma-names = "rx", "tx";
-				fsl,auart-dma-channel = <8 9>;
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
@@ -898,7 +888,7 @@
 			auart1: serial at 8006c000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006c000 0x2000>;
-				interrupts = <113 72 73>;
+				interrupts = <113>;
 				dmas = <&dma_apbx 10>, <&dma_apbx 11>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
@@ -908,7 +898,7 @@
 			auart2: serial at 8006e000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006e000 0x2000>;
-				interrupts = <114 74 75>;
+				interrupts = <114>;
 				dmas = <&dma_apbx 12>, <&dma_apbx 13>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
@@ -918,7 +908,7 @@
 			auart3: serial at 80070000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80070000 0x2000>;
-				interrupts = <115 76 77>;
+				interrupts = <115>;
 				dmas = <&dma_apbx 14>, <&dma_apbx 15>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
@@ -928,7 +918,7 @@
 			auart4: serial at 80072000 {
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80072000 0x2000>;
-				interrupts = <116 78 79>;
+				interrupts = <116>;
 				dmas = <&dma_apbx 0>, <&dma_apbx 1>;
 				dma-names = "rx", "tx";
 				clocks = <&clks 45>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6b8781..ba7eed8 100644
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
