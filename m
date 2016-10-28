From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 15:54:10 +0900
Subject: [PATCH v2 2/4] ARM: dts: sun8i: Add SPI controller node in H3
In-Reply-To: <20161028065412.23008-1-woogyom.kim@gmail.com>
References: <20161028065412.23008-1-woogyom.kim@gmail.com>
Message-ID: <20161028065412.23008-3-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 SPI subsystem is almost same as A31 SPI except buffer size, so those
DT properties are reusable.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 8a59d8d..c38b028 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -439,6 +439,38 @@
 			clocks = <&osc24M>;
 		};
 
+		spi0: spi at 01c68000 {
+			compatible = "allwinner,sun8i-h3-spi";
+			reg = <0x01c68000 0x1000>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pins>;
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi at 01c69000 {
+			compatible = "allwinner,sun8i-h3-spi";
+			reg = <0x01c69000 0x1000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 24>, <&dma 24>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>;
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		wdt0: watchdog at 01c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
-- 
2.9.3
