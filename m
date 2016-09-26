From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 26 Sep 2016 14:54:16 -0400
Subject: [PATCH] ARM: dts: lpc32xx: set pwm1 & pwm2 default clock rate
Message-ID: <1474916056-11336-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Probably most of NXP LPC32xx boards have 13MHz main oscillator
and therefore for HCLK PLL and ARM core clock rate default
hardware setting of 16 * 13MHz = 208MHz and the AHB bus clock
rate of 208MHz / 2 = 104MHz.

The change explicitly defines the peripheral PWM1/PWM2 default
clock output rate of 104MHz. If needed it can be redefined
in a board DTS file.

Signed-off-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
---
Note:
* There is a dependency on the following patch:
  "ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2"
  http://www.spinics.net/lists/arm-kernel/msg530277.html
* This patch should be apply after
  "ARM: dts: lpc32xx: add pwm-cells to base dts file"
  http://www.spinics.net/lists/arm-kernel/msg534050.html
  - There is no dependency between the patches.

 arch/arm/boot/dts/lpc32xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index c031c94..d669200 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -471,6 +471,7 @@
 				clocks = <&clk LPC32XX_CLK_PWM1>;
 				assigned-clocks = <&clk LPC32XX_CLK_PWM1>;
 				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
+				assigned-clock-rates = <104000000>;
 				status = "disabled";
 				#pwm-cells = <2>;
 			};
@@ -481,6 +482,7 @@
 				clocks = <&clk LPC32XX_CLK_PWM2>;
 				assigned-clocks = <&clk LPC32XX_CLK_PWM2>;
 				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
+				assigned-clock-rates = <104000000>;
 				status = "disabled";
 				#pwm-cells = <2>;
 			};
-- 
1.8.3.1
