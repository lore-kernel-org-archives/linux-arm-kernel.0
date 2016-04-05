From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  5 Apr 2016 08:35:51 +0200
Subject: [PATCH 2/6] ARM: dts: pxa: add pxa3xx pwm nodes
In-Reply-To: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
References: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1459838155-28803-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa3xx SoC has 4 PWMs, exactly as the pxa27x does. Add them to the
description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index fec47bcd8292..5767ed4957ae 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -95,6 +95,38 @@
 			clocks = <&clks CLK_USBHOST>;
 			status = "disabled";
 		};
+
+		pwm0: pwm at 40b00000 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40b00000 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM0>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at 40b00010 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40b00010 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM1>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at 40c00000 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40c00000 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM0>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at 40c00010 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40c00010 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM1>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.1.4
