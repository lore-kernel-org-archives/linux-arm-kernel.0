From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:31 -0300
Subject: [PATCH 06/10] ARM: sun7i: enable DMA on SPI
In-Reply-To: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1402890635-12342-7-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of our SPI controllers support DMA transfers, so let's add the
properties here so they can be used when it's best to do so.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c72fad4..c054ad3 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -423,6 +423,8 @@
 			interrupts = <0 10 4>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 27>, <&dma 1 26>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -434,6 +436,8 @@
 			interrupts = <0 11 4>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 9>, <&dma 1 8>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -493,6 +497,8 @@
 			interrupts = <0 12 4>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 29>, <&dma 1 28>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -532,6 +538,8 @@
 			interrupts = <0 50 4>;
 			clocks = <&ahb_gates 23>, <&spi3_clk>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 1 31>, <&dma 1 30>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.0.0
