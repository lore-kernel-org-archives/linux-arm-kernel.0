From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 30 Jun 2014 23:57:58 +0200
Subject: [PATCH 8/9] ARM: dts: sun4i: Add ir controller nodes and pinmux
In-Reply-To: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404165479-23785-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ae6dd50..ec00030 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -593,6 +593,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <1>;
 			};
+
+			ir0_pins_a: ir0 at 0 {
+				allwinner,pins = "PB3","PB4";
+				allwinner,function = "ir0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			ir1_pins_a: ir1 at 0 {
+				allwinner,pins = "PB22","PB23";
+				allwinner,function = "ir1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
@@ -621,6 +635,24 @@
 			status = "disabled";
 		};
 
+		ir0: ir at 01c21800 {
+			compatible = "allwinner,sun4i-a10-ir";
+			clocks = <&apb0_gates 6>, <&ir0_clk>;
+			clock-names = "apb", "ir";
+			interrupts = <5>;
+			reg = <0x01c21800 0x40>;
+			status = "disabled";
+		};
+
+		ir1: ir at 01c21c00 {
+			compatible = "allwinner,sun4i-a10-ir";
+			clocks = <&apb0_gates 7>, <&ir1_clk>;
+			clock-names = "apb", "ir";
+			interrupts = <6>;
+			reg = <0x01c21c00 0x40>;
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
2.0.0
