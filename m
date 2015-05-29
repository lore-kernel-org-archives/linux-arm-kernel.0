From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 29 May 2015 16:33:03 +0200
Subject: [PATCH 2/2] ARM: socfpga: socrates: add gpio-leds
In-Reply-To: <1432909983-19821-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1432909983-19821-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1432909983-19821-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SOCrates has three HPS LEDs that can be turned on/off via gpio.
Use the first one has heartbeat and add the other two as free LEDs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index a81f33deaa3a..019dd2fea208 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -30,6 +30,9 @@
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
 	};
+
+	leds: gpio-leds {
+	};
 };
 
 &gmac1 {
@@ -53,6 +56,26 @@
 	};
 };
 
+&leds {
+	compatible = "gpio-leds";
+
+	led at 0 {
+		label = "led:green:heartbeat";
+		gpios = <&porta 28 1>;
+		linux,default-trigger = "heartbeat";
+	};
+
+	led at 1 {
+		label = "led:green:D7";
+		gpios = <&portb 19 1>;
+	};
+
+	led at 2 {
+		label = "led:green:D8";
+		gpios = <&portb 25 1>;
+	};
+};
+
 &mmc {
 	status = "okay";
 };
-- 
2.1.4
