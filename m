From: luka@openwrt.org (Luka Perkov)
Date: Thu,  3 Oct 2013 05:06:45 +0200
Subject: [PATCH] arm: kirkwood: ib62x0: add u-boot environment partition
Message-ID: <1380769605-2067-1-git-send-email-luka@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, add some trivial cosmetic fixes.

Signed-off-by: Luka Perkov <luka@openwrt.org>
---
 arch/arm/boot/dts/kirkwood-ib62x0.dts | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index cb711a3..3f970c6 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -5,7 +5,7 @@
 
 / {
 	model = "RaidSonic ICY BOX IB-NAS62x0 (Rev B)";
-	compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0",  "marvell,kirkwood-88f6281", "marvell,kirkwood";
+	compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
@@ -43,6 +43,7 @@
 				marvell,function = "gpio";
 			};
 		};
+
 		serial at 12000 {
 			status = "okay";
 		};
@@ -59,7 +60,12 @@
 
 			partition at 0 {
 				label = "u-boot";
-				reg = <0x0000000 0x100000>;
+				reg = <0x0000000 0xe0000>;
+			};
+
+			partition at e0000 {
+				label = "u-boot environment";
+				reg = <0xe0000 0x100000>;
 			};
 
 			partition at 100000 {
@@ -71,7 +77,6 @@
 				label = "root";
 				reg = <0x0700000 0xf900000>;
 			};
-
 		};
 	};
 
@@ -93,6 +98,7 @@
 			gpios = <&gpio0 28 1>;
 		};
 	};
+
 	gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-0 = <&pmx_led_os_red &pmx_led_os_green
@@ -113,14 +119,13 @@
 			gpios = <&gpio0 27 0>;
 		};
 	};
+
 	gpio_poweroff {
 		compatible = "gpio-poweroff";
 		pinctrl-0 = <&pmx_power_off>;
 		pinctrl-names = "default";
 		gpios = <&gpio0 24 0>;
 	};
-
-
 };
 
 &mdio {
@@ -134,6 +139,7 @@
 
 &eth0 {
 	status = "okay";
+
 	ethernet0-port at 0 {
 		phy-handle = <&ethphy0>;
 	};
-- 
1.8.4
