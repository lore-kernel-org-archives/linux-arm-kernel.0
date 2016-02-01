From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 09:57:27 +0100
Subject: [PATCH 1/5] ARM: pb1176: add ICST307 clocks to the device tree
Message-ID: <1454317047-4698-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the five ICST307 clocks to the device tree, so we
can use these with e.g. CLCD.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 1bc64cda819e..5edcf596eccc 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -176,6 +176,41 @@
 				label = "versatile:7";
 				default-state = "off";
 			};
+			oscclk0: osc0 at 0c {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x0C>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk1: osc1 at 10 {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x10>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk2: osc2 at 14 {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x14>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk3: osc3 at 18 {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x18>;
+				clocks = <&xtal24mhz>;
+			};
+			oscclk4: osc4 at 1c {
+				compatible = "arm,syscon-icst307";
+				#clock-cells = <0>;
+				lock-offset = <0x20>;
+				vco-offset = <0x1c>;
+				clocks = <&xtal24mhz>;
+			};
 		};
 
 		/* Primary DevChip GIC synthesized with the CPU */
-- 
2.4.3
