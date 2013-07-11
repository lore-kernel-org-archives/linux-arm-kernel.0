From: marex@denx.de (Marek Vasut)
Date: Thu, 11 Jul 2013 21:30:16 +0200
Subject: [PATCH] ARM: mxs: Add backlight support for M28EVK
Message-ID: <1373571016-22268-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds backlight support for M28EVK.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-m28evk.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 44d9da5..0d322a2 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -235,6 +235,12 @@
 				pinctrl-0 = <&auart2_2pins_b>;
 				status = "okay";
 			};
+
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm4_pins_a>;
+				status = "okay";
+			};
 		};
 	};
 
@@ -270,6 +276,13 @@
 		};
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 4 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 
-- 
1.7.10.4
