From: bart.tanghe@thomasmore.be (Bart Tanghe)
Date: Mon,  5 Jan 2015 16:33:03 +0100
Subject: [PATCH]dts: add bcm2835-pwm bindings
Message-ID: <1420471983-29945-1-git-send-email-bart.tanghe@thomasmore.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To probe the bcm2835-pwm driver properly, this dts bindings has to be added 
to the bcm2835 dtsi file.
In expectation of a bcm2835 clock driver, I've added fixed-clock clock binding.
To change the status of the gpio pins into pwm output pins, some additional 
bindings has to be added but this has not to be done automatically.
Is it possible to document this bindings somewhere?

Signed-off-by: Bart Tanghe <bart.tanghe@thomasmore.be>

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3342cb1..ba76bb4 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -146,6 +147,14 @@
 			interrupts = <1 9>;
 		};
 
+		pwm: pwm at 7E20C000 {
+			compatible = "brcm,bcm2835-pwm";
+			reg = <0x7e20c000 0x28>;
+			clocks = <&clk_pwm>;
+			#pwm-cells = <2>;
+			status = "ok";
+		};
+
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
@@ -179,5 +188,13 @@
 			clock-output-names = "spi";
 			clock-frequency = <250000000>;
 		};
+
+		clk_pwm: pwm at 3 {
+			compatible = "fixed-clock";
+			reg = <3>;
+			#clock-cells = <0>;
+			clock-output-names = "pwm";
+			clock-frequency = <9200000>;
+		};
 	};
 };
