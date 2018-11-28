From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 28 Nov 2018 11:42:30 +0900
Subject: [PATCH] ARM: dts: uniphier: add MIO DMAC nodes
Message-ID: <1543372950-16122-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MIO-DMAC (Media IO DMA Controller) nodes, and use them as
the DMA engine of SD/eMMC controllers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 14 ++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index b73d594..c2706ce 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -235,6 +235,16 @@
 			};
 		};
 
+		dmac: dma-controller at 5a000000 {
+			compatible = "socionext,uniphier-mio-dmac";
+			reg = <0x5a000000 0x1000>;
+			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+				     <0 71 4>, <0 72 4>, <0 73 4>;
+			clocks = <&mio_clk 7>;
+			resets = <&mio_rst 7>;
+			#dma-cells = <1>;
+		};
+
 		sd: sdhc at 5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
@@ -246,6 +256,8 @@
 			clocks = <&mio_clk 0>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 0>, <&mio_rst 3>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 4>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 			sd-uhs-sdr12;
@@ -263,6 +275,8 @@
 			clocks = <&mio_clk 1>;
 			reset-names = "host", "bridge", "hw";
 			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 6>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			cap-mmc-hw-reset;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 0beb606..97d051e 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -269,6 +269,16 @@
 			};
 		};
 
+		dmac: dma-controller at 5a000000 {
+			compatible = "socionext,uniphier-mio-dmac";
+			reg = <0x5a000000 0x1000>;
+			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+				     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
+			clocks = <&mio_clk 7>;
+			resets = <&mio_rst 7>;
+			#dma-cells = <1>;
+		};
+
 		sd: sdhc at 5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
@@ -280,6 +290,8 @@
 			clocks = <&mio_clk 0>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 0>, <&mio_rst 3>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 4>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 			sd-uhs-sdr12;
@@ -297,6 +309,8 @@
 			clocks = <&mio_clk 1>;
 			reset-names = "host", "bridge", "hw";
 			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 5>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			cap-mmc-hw-reset;
@@ -313,6 +327,8 @@
 			clocks = <&mio_clk 2>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 2>, <&mio_rst 5>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 6>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 		};
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index f7fcf6b..efce027 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -239,6 +239,16 @@
 			};
 		};
 
+		dmac: dma-controller at 5a000000 {
+			compatible = "socionext,uniphier-mio-dmac";
+			reg = <0x5a000000 0x1000>;
+			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+				     <0 71 4>, <0 72 4>, <0 73 4>;
+			clocks = <&mio_clk 7>;
+			resets = <&mio_rst 7>;
+			#dma-cells = <1>;
+		};
+
 		sd: sdhc at 5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
@@ -250,6 +260,8 @@
 			clocks = <&mio_clk 0>;
 			reset-names = "host", "bridge";
 			resets = <&mio_rst 0>, <&mio_rst 3>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 4>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 			sd-uhs-sdr12;
@@ -267,6 +279,8 @@
 			clocks = <&mio_clk 1>;
 			reset-names = "host", "bridge", "hw";
 			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			dma-names = "rx-tx";
+			dmas = <&dmac 6>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			cap-mmc-hw-reset;
-- 
2.7.4
