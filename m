From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 12 Apr 2014 23:25:58 +0200
Subject: [PATCHv2 6/7] ARM: sun7i: dt: add PWM support
In-Reply-To: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1397337959-12408-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PWM bindings for the Allwinner A20.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c6eb881a3ced..19d1f60209c5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -692,6 +692,14 @@
 			interrupts = <0 24 4>;
 		};
 
+		pwm: pwm at 01c20e00 {
+			compatible = "allwinner,sun7i-a20-pwm";
+			reg = <0x01c20e00 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
-- 
1.8.3.2
