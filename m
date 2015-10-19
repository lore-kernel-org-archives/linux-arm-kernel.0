From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Oct 2015 15:17:19 +0800
Subject: [PATCH] arm: dts: berlin2q: remove duplicated interrupt-parent
Message-ID: <1445239039-2262-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default interrupt-parent has been set in the upper layer, apb at e80000
and apb at fc0000 for example. So if the interrupt-parent isn't changed, we
don't need to set it again. This patch removes the dumplicated
interrupt-parent settings.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 63a4849..a3ecde5 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -293,7 +293,6 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x1400 0x100>;
-				interrupt-parent = <&aic>;
 				interrupts = <4>;
 				clocks = <&chip_clk CLKID_CFG>;
 				pinctrl-0 = <&twsi0_pmux>;
@@ -306,7 +305,6 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x1800 0x100>;
-				interrupt-parent = <&aic>;
 				interrupts = <5>;
 				clocks = <&chip_clk CLKID_CFG>;
 				pinctrl-0 = <&twsi1_pmux>;
@@ -505,7 +503,6 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x7000 0x100>;
-				interrupt-parent = <&sic>;
 				interrupts = <6>;
 				clocks = <&refclk>;
 				pinctrl-0 = <&twsi2_pmux>;
@@ -518,7 +515,6 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x8000 0x100>;
-				interrupt-parent = <&sic>;
 				interrupts = <7>;
 				clocks = <&refclk>;
 				pinctrl-0 = <&twsi3_pmux>;
@@ -529,7 +525,6 @@
 			uart0: uart at 9000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x9000 0x100>;
-				interrupt-parent = <&sic>;
 				interrupts = <8>;
 				clocks = <&refclk>;
 				reg-shift = <2>;
@@ -541,7 +536,6 @@
 			uart1: uart at a000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0xa000 0x100>;
-				interrupt-parent = <&sic>;
 				interrupts = <9>;
 				clocks = <&refclk>;
 				reg-shift = <2>;
-- 
2.6.1
