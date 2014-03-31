From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 31 Mar 2014 14:07:29 +0200
Subject: [PATCH 4/4] ARM: sunxi: dt: Add PWM support for the cubietruck
In-Reply-To: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1396267649-18009-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables the PWM for both PWM channels on the cubietruck. They can be found on
connector CN8.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index f9dcb61a5305..b6843839b380 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -28,6 +28,12 @@
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
