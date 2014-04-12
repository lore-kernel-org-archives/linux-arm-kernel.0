From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 12 Apr 2014 23:25:59 +0200
Subject: [PATCHv2 7/7] ARM: sunxi: dt: add PWM support for the cubietruck
In-Reply-To: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1397337959-12408-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the PWM for both PWM channels on the cubietruck. They can be found on
connector CN8.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index cb25d3c8da58..0c3bd127a5fd 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -63,6 +63,12 @@
 			};
 		};
 
+		pwm: pwm at 01c20e00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm0_pins_a>, <&pwm1_pins_a>;
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
-- 
1.8.3.2
