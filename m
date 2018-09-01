From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  1 Sep 2018 21:29:41 +0200
Subject: [PATCH] ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs
Message-ID: <1535830181-17254-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the LAN7515 on Raspberry Pi 3B+ doesn't have an EEPROM and the OTP
is empty, we need to enable the Ethernet LEDs via Device Tree.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi b/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
index 9403da0..70bece6 100644
--- a/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
+++ b/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/net/microchip-lan78xx.h>
+
 / {
 	aliases {
 		ethernet0 = &ethernet;
@@ -21,6 +23,18 @@
 			ethernet: ethernet at 1 {
 				compatible = "usb424,7800";
 				reg = <1>;
+
+				mdio {
+					#address-cells = <0x1>;
+					#size-cells = <0x0>;
+					eth_phy: ethernet-phy at 1 {
+						reg = <1>;
+						microchip,led-modes = <
+							LAN78XX_LINK_1000_ACTIVITY
+							LAN78XX_LINK_10_100_ACTIVITY
+						>;
+					};
+				};
 			};
 		};
 	};
-- 
2.7.4
