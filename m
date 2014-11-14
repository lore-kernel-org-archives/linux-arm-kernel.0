From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 14 Nov 2014 11:08:52 +0100
Subject: [PATCH 4/4] ARM: at91/dt: enable the RTT block on the
 at91sam9m10g45ek board
In-Reply-To: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415959732-13591-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RTT and GPBR devices and specify the general purpose register
used to store the current time.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index d8dd226..33ce7ca 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -161,6 +161,15 @@
 				pinctrl-0 = <&pinctrl_pwm_leds>;
 			};
 
+			rtc at fffffd20 {
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+				status = "okay";
+			};
+
+			gpbr: syscon at fffffd60 {
+				status = "okay";
+			};
+
 			rtc at fffffdb0 {
 				status = "okay";
 			};
-- 
1.9.1
