From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 17:55:24 +0100
Subject: [PATCH 1/2] ARM: Kirkwood: topkick: Fix SoC type and add missing pins
In-Reply-To: <f6d483f3fb83826bce16f956afa013f0bcf11f52.1359146831.git.jason@lakedaemon.net>
References: <f6d483f3fb83826bce16f956afa013f0bcf11f52.1359146831.git.jason@lakedaemon.net>
Message-ID: <1359219326-5927-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Topkick contains a Marvell 6282, not an 6281 as included in the
kirkwood-topkick.dts file.

Also, add pinhogs for the serial port and nand devices.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-topkick.dts |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index edefbb5..c8e8a64 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
 /include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+/include/ "kirkwood-6282.dtsi"
 
 / {
 	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
@@ -50,7 +50,9 @@
 				      &pmx_sw_right
 				      &pmx_sw_idle
 				      &pmx_sw_left2
-				      &pmx_led_wifi_yellow >;
+				      &pmx_led_wifi_yellow
+				      &pmx_uart0
+				      &pmx_nand >;
 			pinctrl-names = "default";
 
 			pmx_led_disk_yellow: pmx-led-disk-yellow {
-- 
1.7.10.4
