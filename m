From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 17:55:25 +0100
Subject: [PATCH 2/2] ARM: Kirkwood: topkick: Enable i2c bus.
In-Reply-To: <1359219326-5927-1-git-send-email-andrew@lunn.ch>
References: <f6d483f3fb83826bce16f956afa013f0bcf11f52.1359146831.git.jason@lakedaemon.net>
 <1359219326-5927-1-git-send-email-andrew@lunn.ch>
Message-ID: <1359219326-5927-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 arch/arm/boot/dts/kirkwood-topkick.dts |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index c8e8a64..75fc1dd 100644
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
@@ -159,6 +160,9 @@
 		egiga0 {
 			status = "ok";
 		};
+		i2c at 11000 {
+			status = "ok";
+		};
 	};
 
 	gpio-leds {
-- 
1.7.10.4
