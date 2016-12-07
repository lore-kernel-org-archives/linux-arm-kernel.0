From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed,  7 Dec 2016 14:30:47 -0500
Subject: [PATCH v2] ARM: dts: lpc32xx: add pwm-cells to base dts file
Message-ID: <1481139047-13166-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

There is no need to define the "pwm-cells" in the board
specific dts file; move the entry to the base dts file.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes in v2:
* Update the "pwm-cells" to be compatible with the latest
  lpc32xx-pwm driver implementation.

Note:
* This patch have a dependency on the following patcheset:
  "pwm: lpc32xx: switch driver to one phandle argument for PWM consumers"
  http://www.spinics.net/lists/arm-kernel/msg547013.html

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
+				#pwm-cells = <1>;
 			};
 
 			pwm2: pwm at 4005C004 {
@@ -481,6 +482,7 @@
 				assigned-clocks = <&clk LPC32XX_CLK_PWM2>;
 				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
 				status = "disabled";
+				#pwm-cells = <1>;
 			};
 
 			timer3: timer at 40060000 {
-- 
1.8.3.1
