From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 20:50:12 +0000
Subject: [PATCH V4 03/11] ARM: Kirkwood: topkick: Enable i2c bus.
In-Reply-To: <cover.1359232975.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359232975.git.jason@lakedaemon.net>
Message-ID: <01661ac5cc55bb4f6e7ae3ca19f799f64cbe7ff5.1359232975.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Add a DT node for I2C and pinctrl hog for the pins. There appears to
be an i2c bus on topkick with a device on it:

i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- 64 -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-topkick.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 9ae2d2c..131aae5 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -52,7 +52,8 @@
 				      &pmx_sw_left2
 				      &pmx_led_wifi_yellow
 				      &pmx_uart0
-				      &pmx_nand >;
+				      &pmx_nand
+				      &pmx_twsi0 >;
 			pinctrl-names = "default";
 
 			pmx_led_disk_yellow: pmx-led-disk-yellow {
@@ -151,6 +152,10 @@
 			status = "okay";
 			/* No CD or WP GPIOs */
 		};
+
+		i2c at 11000 {
+			status = "ok";
+		};
 	};
 
 	gpio-leds {
-- 
1.8.1.1
