From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed,  7 Sep 2016 15:37:53 -0400
Subject: [RESEND PATCH] ARM: dts: lpc32xx: set default parent clock for pwm1 &
 pwm2
Message-ID: <1473277073-12093-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The change setup the peripheral clock (PERIPH_CLK) as the default 
parent clock for PWM1 & PWM2.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index e295e1e..ed85b95 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -469,6 +469,9 @@
 				compatible = "nxp,lpc3220-pwm";
 				reg = <0x4005C000 0x4>;
 				clocks = <&clk LPC32XX_CLK_PWM1>;
+				assigned-clocks = <&clk LPC32XX_CLK_PWM1>,
+						  <&clk LPC32XX_CLK_PERIPH>;
+				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
 				status = "disabled";
 			};
 
@@ -476,6 +479,9 @@
 				compatible = "nxp,lpc3220-pwm";
 				reg = <0x4005C004 0x4>;
 				clocks = <&clk LPC32XX_CLK_PWM2>;
+				assigned-clocks = <&clk LPC32XX_CLK_PWM2>,
+						  <&clk LPC32XX_CLK_PERIPH>;
+				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
 				status = "disabled";
 			};
 
-- 
1.8.3.1
