From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Oct 2015 11:55:05 +0200
Subject: [PATCH v3 1/4] ARM: dts: sun5i: Add PWM controller node for A13 / A10s
Message-ID: <1444557308-10892-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dts nodes for the PWM controller on the A13 / A10s.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-Use a separate compatible string for a10s and a13
---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0fdabe8..f7dcf4e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -165,6 +165,14 @@
 			#size-cells = <0>;
 		};
 
+		pwm: pwm at 01c20e00 {
+			compatible = "allwinner,sun5i-a10s-pwm";
+			reg = <0x01c20e00 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index f3631c9..d910d3a 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -150,6 +150,16 @@
 					     "apb1_uart3";
 		};
 	};
+
+	soc at 01c00000 {
+		pwm: pwm at 01c20e00 {
+			compatible = "allwinner,sun5i-a13-pwm";
+			reg = <0x01c20e00 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+	};
 };
 
 &cpu0 {
-- 
2.5.0
