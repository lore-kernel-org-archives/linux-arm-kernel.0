From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 14 Oct 2013 18:07:27 +0000
Subject: [PATCH] ARM: mvebu: dts: remove unneeded linux,
 default-state from led nodes
Message-ID: <1381774047-23354-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generally, power LEDs should indicate when power is applied, and go out
once power is removed.  _Not_ annoy the developer with migraine-inducing
blinking reminicent of some badly animated television series designed to
sell sugar to children.

On a more serious note, most of these OS-specific properties aren't
necessary and should be removed.  I left two that are legitimately tying
disk LEDs to disk activity.  Other than that, we keep the state the
bootloader left them in until userspace changes the state via sysfs.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/armada-370-mirabox.dts               | 4 ++--
 arch/arm/boot/dts/armada-370-netgear-rn102.dts         | 2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts       | 3 +--
 arch/arm/boot/dts/dove-cubox.dts                       | 2 +-
 arch/arm/boot/dts/kirkwood-dns320.dts                  | 2 +-
 arch/arm/boot/dts/kirkwood-dns325.dts                  | 2 +-
 arch/arm/boot/dts/kirkwood-dockstar.dts                | 2 +-
 arch/arm/boot/dts/kirkwood-goflexnet.dts               | 2 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts                  | 2 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts                | 4 ++--
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts          | 2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi                   | 2 +-
 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 2 +-
 arch/arm/boot/dts/kirkwood-ns2lite.dts                 | 2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts        | 2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts              | 2 +-
 16 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 2471d9d..41457e5 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -74,13 +74,13 @@
 				green_pwr_led {
 					label = "mirabox:green:pwr";
 					gpios = <&gpio1 31 1>;
-					linux,default-trigger = "heartbeat";
+					default-state = "keep";
 				};
 
 				blue_stat_led {
 					label = "mirabox:blue:stat";
 					gpios = <&gpio2 0 1>;
-					linux,default-trigger = "cpu0";
+					default-state = "off";
 				};
 
 				green_stat_led {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 05e4485..4b2dfd7 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -130,7 +130,7 @@
 		blue_power_led {
 			label = "rn102:blue:pwr";
 			gpios = <&gpio1 25 1>;  /* GPIO 57 Active Low */
-			linux,default-trigger = "heartbeat";
+			default-state = "keep";
 		};
 
 		green_sata1_led {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 5695afc..99bcf76 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -103,8 +103,7 @@
 				green_led {
 					label = "green_led";
 					gpios = <&gpio1 21 1>;
-					default-state = "off";
-					linux,default-trigger = "heartbeat";
+					default-state = "keep";
 				};
 			};
 
diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 8349a24..7a70f4c 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -23,7 +23,7 @@
 		power {
 			label = "Power";
 			gpios = <&gpio0 18 1>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index e112ca6..ff13b93 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -25,7 +25,7 @@
 		blue-power {
 			label = "dns320:blue:power";
 			gpios = <&gpio0 26 1>; /* GPIO 26 Active Low */
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 		blue-usb {
 			label = "dns320:blue:usb";
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
index 5119fb8..f433043 100644
--- a/arch/arm/boot/dts/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -25,7 +25,7 @@
 		white-power {
 			label = "dns325:white:power";
 			gpios = <&gpio0 26 1>; /* GPIO 26 Active Low */
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 		white-usb {
 			label = "dns325:white:usb";
diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 33ff368..a5f1e39 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -43,7 +43,7 @@
 		health {
 			label = "status:green:health";
 			gpios = <&gpio1 14 1>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 		fault {
 			label = "status:orange:fault";
diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index a43bebb..a9e98c9 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -86,7 +86,7 @@
 		health {
 			label = "status:green:health";
 			gpios = <&gpio1 14 1>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 		fault {
 			label = "status:orange:fault";
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index c5fb02f..dbc9033 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -82,7 +82,7 @@
 		green-os {
 			label = "ib62x0:green:os";
 			gpios = <&gpio0 25 0>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 		red-os {
 			label = "ib62x0:red:os";
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 4a62b20..399fb0c 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -95,12 +95,12 @@
 		led-level {
 			label = "led_level";
 			gpios = <&gpio1 9 0>;
-			linux,default-trigger = "default-on";
+			default-state = "on";
 		};
 		power-blue {
 			label = "power:blue";
 			gpios = <&gpio1 10 0>;
-			linux,default-trigger = "timer";
+			default-state = "keep";
 		};
 		power-red {
 			label = "power:red";
diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index d15395d..b9de441 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -128,7 +128,7 @@
 		power_led {
 			label = "status:white:power_led";
 			gpios = <&gpio0 16 0>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 		rebuild_led {
 			label = "status:white:rebuild_led";
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 4e8f9e4..bc34a60 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -150,7 +150,7 @@
 		led at 4 {
 			label = "lsxl:blue:power";
 			gpios = <&gpio1 7 1>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 
 		led at 5 {
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index e6a102c..6b96e85 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -113,7 +113,7 @@
 		power_led {
 			label = "status:blue:power_led";
 			gpios = <&gpio0 31 1>;   /* GPIO 31 Active Low */
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 		activity_led {
 			label = "status:blue:activity_led";
diff --git a/arch/arm/boot/dts/kirkwood-ns2lite.dts b/arch/arm/boot/dts/kirkwood-ns2lite.dts
index 2796070..7cea2a4 100644
--- a/arch/arm/boot/dts/kirkwood-ns2lite.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2lite.dts
@@ -26,7 +26,7 @@
 		blue-sata {
 			label = "ns2:blue:sata";
 			gpios = <&gpio0 30 1>;
-			linux,default-trigger = "default-on";
+			linux,default-trigger = "ide-disk";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
index eac6a21..ce9b3be 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
@@ -37,7 +37,7 @@
 		health {
 			label = "sheevaplug:blue:health";
 			gpios = <&gpio1 17 1>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
index bb61918..1eff4f6 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
@@ -32,7 +32,7 @@
 		health {
 			label = "sheevaplug:blue:health";
 			gpios = <&gpio1 17 1>;
-			linux,default-trigger = "default-on";
+			default-state = "keep";
 		};
 
 		misc {
-- 
1.8.3.2
