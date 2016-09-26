From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 26 Sep 2016 14:47:21 -0400
Subject: [PATCH] ARM: dts: lpc32xx: add pwm-cells to base dts file
Message-ID: <1474915641-11209-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

There is no need to define the "pwm-cells" in the board
specific dts file; move the entry to the base dts file.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Note:
* This patch should be apply after
  "ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2"
  http://www.spinics.net/lists/arm-kernel/msg530277.html
  - There is no dependency between the patches.

 arch/arm/boot/dts/lpc32xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 218d9fa..c031c94 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -472,6 +472,7 @@
 				assigned-clocks = <&clk LPC32XX_CLK_PWM1>;
 				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
 				status = "disabled";
+				#pwm-cells = <2>;
 			};
 
 			pwm2: pwm at 4005C004 {
@@ -481,6 +482,7 @@
 				assigned-clocks = <&clk LPC32XX_CLK_PWM2>;
 				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
 				status = "disabled";
+				#pwm-cells = <2>;
 			};
 
 			timer3: timer at 40060000 {
-- 
1.8.3.1
