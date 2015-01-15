From: bart.tanghe@thomasmore.be (Bart Tanghe)
Date: Thu, 15 Jan 2015 13:33:10 +0100
Subject: [PATCH v4] ARM: dts: add bcm2835-pwm bindings
Message-ID: <1421325190-7648-1-git-send-email-bart.tanghe@thomasmore.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To probe the bcm2835-pwm driver properly, this dts bindings has to be added 
to the bcm2835 dtsi file.
In expectation of a bcm2835 clock driver, I've added fixed-clock clock binding. 
---
Changes in v4:
 - node added by reg value  

Signed-off-by: Bart Tanghe <bart.tanghe@thomasmore.be>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3342cb1..e8a0f13 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -122,6 +123,14 @@
 			status = "disabled";
 		};
 
+                pwm: pwm at 7e20c000 {
+                        compatible = "brcm,bcm2835-pwm";
+                        reg = <0x7e20c000 0x28>;
+                        clocks = <&clk_pwm>;
+                        #pwm-cells = <2>;
+                        status = "disabled";
+                };
+
 		sdhci: sdhci at 7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
@@ -179,5 +188,13 @@
 			clock-output-names = "spi";
 			clock-frequency = <250000000>;
 		};
+
+		clk_pwm: clock at 3 {
+			compatible = "fixed-clock";
+			reg = <3>;
+			#clock-cells = <0>;
+			clock-output-names = "pwm";
+			clock-frequency = <9200000>;
+		};
 	};
 };
