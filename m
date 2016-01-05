From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jan 2016 15:02:08 +0100
Subject: [PATCH 1/2] ARM: versatile: add the syscon LEDs to the DT
In-Reply-To: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
References: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1452002529-3335-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree version of Versatile AP/PB never had LED support
so we are missing LEDs from our hardware boards. Add this as
syscon LEDs like we did for Integrator and Juno. We need to
spawn devices in the syscon with "simple-mfd" for this to work.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/versatile-ab.dts | 62 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 3279bf1a17a1..6fd7efbead34 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -30,9 +30,69 @@
 	};
 
 	core-module at 10000000 {
-		compatible = "arm,core-module-versatile", "syscon";
+		compatible = "arm,core-module-versatile", "syscon", "simple-mfd";
 		reg = <0x10000000 0x200>;
 
+		led at 08.0 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x01>;
+			label = "versatile:0";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+		led at 08.1 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x02>;
+			label = "versatile:1";
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+		led at 08.2 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x04>;
+			label = "versatile:2";
+			linux,default-trigger = "cpu0";
+			default-state = "off";
+		};
+		led at 08.3 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x08>;
+			label = "versatile:3";
+			default-state = "off";
+		};
+		led at 08.4 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x10>;
+			label = "versatile:4";
+			default-state = "off";
+		};
+		led at 08.5 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x20>;
+			label = "versatile:5";
+			default-state = "off";
+		};
+		led at 08.6 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x40>;
+			label = "versatile:6";
+			default-state = "off";
+		};
+		led at 08.7 {
+			compatible = "register-bit-led";
+			offset = <0x08>;
+			mask = <0x80>;
+			label = "versatile:7";
+			default-state = "off";
+		};
+
 		/* OSC1 on AB, OSC4 on PB */
 		osc1: cm_aux_osc at 24M {
 			#clock-cells = <0>;
-- 
2.4.3
