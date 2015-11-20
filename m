From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:05:11 +0200
Subject: [PATCH 11/11] arm: dts: lpc32xx: remove clock frequency property from
 UART device nodes
In-Reply-To: <1447981511-29653-1-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
Message-ID: <1447981511-29653-12-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If clock-frequency property is given, then it substitutes calculation
of supplying clock frequency from parent clock, this may break UART,
if parent clock is given and managed by common clock framework.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 68bf011..f396343 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -209,7 +209,6 @@
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40090000 0x1000>;
 				interrupts = <9 0>;
-				clock-frequency = <13000000>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART5>;
 				status = "disabled";
@@ -219,7 +218,6 @@
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40080000 0x1000>;
 				interrupts = <7 0>;
-				clock-frequency = <13000000>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART3>;
 				status = "disabled";
@@ -229,7 +227,6 @@
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40088000 0x1000>;
 				interrupts = <8 0>;
-				clock-frequency = <13000000>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART4>;
 				status = "disabled";
@@ -239,7 +236,6 @@
 				compatible = "nxp,lpc3220-uart";
 				reg = <0x40098000 0x1000>;
 				interrupts = <10 0>;
-				clock-frequency = <13000000>;
 				reg-shift = <2>;
 				clocks = <&clk LPC32XX_CLK_UART6>;
 				status = "disabled";
-- 
2.1.4
