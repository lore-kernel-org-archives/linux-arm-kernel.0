From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 19 Sep 2016 19:53:45 +0530
Subject: [PATCH 1/3] arm: dts: imx7: Update #pwm-cells for PWM polarity control
In-Reply-To: <20160919142347.11342-1-bhuvanchandra.dv@toradex.com>
References: <20160919142347.11342-1-bhuvanchandra.dv@toradex.com>
Message-ID: <20160919142347.11342-2-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update #pwm-cells to 3 in order to support PWM signal polarity control.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 6 +++---
 arch/arm/boot/dts/imx7s.dtsi                      | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index e00c2e9..c61bdf8 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -6,8 +6,8 @@ Required properties:
   - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
   - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
-  the cells format.
+- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.txt
+  in this directory for a description of the cells format.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
 See the clock consumer binding,
@@ -17,7 +17,7 @@ See the clock consumer binding,
 Example:
 
 pwm1: pwm at 53fb4000 {
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
 	reg = <0x53fb4000 0x4000>;
 	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 0d7d5ac..8d1d471 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -601,7 +601,7 @@
 				clocks = <&clks IMX7D_PWM1_ROOT_CLK>,
 					 <&clks IMX7D_PWM1_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -612,7 +612,7 @@
 				clocks = <&clks IMX7D_PWM2_ROOT_CLK>,
 					 <&clks IMX7D_PWM2_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -623,7 +623,7 @@
 				clocks = <&clks IMX7D_PWM3_ROOT_CLK>,
 					 <&clks IMX7D_PWM3_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -634,7 +634,7 @@
 				clocks = <&clks IMX7D_PWM4_ROOT_CLK>,
 					 <&clks IMX7D_PWM4_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
-- 
2.9.2
