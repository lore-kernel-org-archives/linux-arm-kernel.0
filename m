From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 16 Feb 2017 15:27:47 -0500
Subject: [RESEND PATCH 1/3] dt: pwm: lpc32xx: add description of clocks and
 #pwm-cells properties
In-Reply-To: <20170216202749.20653-1-slemieux.tyco@gmail.com>
References: <20170216202749.20653-1-slemieux.tyco@gmail.com>
Message-ID: <20170216202749.20653-2-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Zapolskiy <vz@mleia.com>

NXP LPC32xx SoCs have two simple independent PWM controllers with a single
output each, in this case there is no need to specify PWM channel argument
on client side, one cell for setting PWM output frequency is sufficient.

Another added to the description property 'clocks' has a standard meaning
of a controller supply clock, in the LPC32xx User's Manual the clock is
denoted as PWM1_CLK or PWM2_CLK clock.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
index 74b5bc5dd19a..523d79662861 100644
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
@@ -3,15 +3,22 @@ LPC32XX PWM controller
 Required properties:
 - compatible: should be "nxp,lpc3220-pwm"
 - reg: physical base address and length of the controller's registers
+- clocks: clock phandle and clock specifier pair
+- #pwm-cells: should be 1, the cell is used to specify the period in
+  nanoseconds.
 
 Examples:
 
 pwm at 4005c000 {
 	compatible = "nxp,lpc3220-pwm";
 	reg = <0x4005c000 0x4>;
+	clocks = <&clk LPC32XX_CLK_PWM1>;
+	#pwm-cells = <1>;
 };
 
 pwm at 4005c004 {
 	compatible = "nxp,lpc3220-pwm";
 	reg = <0x4005c004 0x4>;
+	clocks = <&clk LPC32XX_CLK_PWM2>;
+	#pwm-cells = <1>;
 };
-- 
2.11.0
