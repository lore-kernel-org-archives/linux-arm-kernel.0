From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon,  4 Aug 2014 17:10:01 -0300
Subject: [PATCH v3 7/8] ARM: sun5i: dt: enable DMA on SPI
In-Reply-To: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1407183002-29420-8-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of our SPI controllers support DMA transfers, so let's add the
properties here so they can be used when it's best to do so.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---

Changes from v2:
 * Collect tag from Chen-Yu

 arch/arm/boot/dts/sun5i-a10s.dtsi | 6 ++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 8b5a27c..2ee786a 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -314,6 +314,8 @@
 			interrupts = <10>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 27>, <&dma 1 26>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -325,6 +327,8 @@
 			interrupts = <11>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 9>, <&dma 1 8>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -411,6 +415,8 @@
 			interrupts = <12>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 29>, <&dma 1 28>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 139f4ac..6e0823b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -312,6 +312,8 @@
 			interrupts = <10>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 27>, <&dma 1 26>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -323,6 +325,8 @@
 			interrupts = <11>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 9>, <&dma 1 8>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -384,6 +388,8 @@
 			interrupts = <12>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 29>, <&dma 1 28>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.0.4
