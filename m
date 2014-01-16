From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Jan 2014 18:11:25 +0100
Subject: [PATCH 4/4] ARM: sun6i: dt: Add SPI controllers to the A31 DTSI
In-Reply-To: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1389892285-11745-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has 4 SPI controllers. Add them in the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ae058eb..288cc8e 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -340,6 +340,46 @@
 			status = "disabled";
 		};
 
+		spi0: spi at 01c68000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c68000 0x1000>;
+			interrupts = <0 65 4>;
+			clocks = <&ahb1_gates 20>, <&spi0_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 20>;
+			status = "disabled";
+		};
+
+		spi1: spi at 01c69000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c69000 0x1000>;
+			interrupts = <0 66 4>;
+			clocks = <&ahb1_gates 21>, <&spi1_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 21>;
+			status = "disabled";
+		};
+
+		spi2: spi at 01c6a000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c6a000 0x1000>;
+			interrupts = <0 67 4>;
+			clocks = <&ahb1_gates 22>, <&spi2_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 22>;
+			status = "disabled";
+		};
+
+		spi3: spi at 01c6b000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c6b000 0x1000>;
+			interrupts = <0 68 4>;
+			clocks = <&ahb1_gates 23>, <&spi3_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 23>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
1.8.4.2
