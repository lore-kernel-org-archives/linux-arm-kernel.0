From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:12 +0100
Subject: [PATCH 15/19] ARM: dts: omap: replace legacy *,
 wakeup property with wakeup-source
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-16-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard and other driver will continue to support the legacy
"gpio-key,wakeup", "linux,wakeup" boolean property to enable the wakeup
source, "wakeup-source" is the new standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  8 ++---
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    | 18 ++++++------
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-n900.dts                   | 10 +++----
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |  2 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |  4 +--
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |  4 +--
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi   |  4 +--
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |  4 +--
 arch/arm/boot/dts/omap3-pandora-common.dtsi        | 34 +++++++++++-----------
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |  2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  2 +-
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  2 +-
 22 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 91146c318798..caeb3b076042 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -23,28 +23,28 @@
 			label = "sysboot2";
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;	/* gpio2 */
 			linux,code = <BTN_0>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		sysboot5 {
 			label = "sysboot5";
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;	/* gpio7 */
 			linux,code = <BTN_1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		gpio1 {
 			label = "gpio1";
 			gpios = <&gpio6 21 GPIO_ACTIVE_LOW>;	/* gpio181 */
 			linux,code = <BTN_2>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		gpio2 {
 			label = "gpio2";
 			gpios = <&gpio6 18 GPIO_ACTIVE_LOW>;	/* gpio178 */
 			linux,code = <BTN_3>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 7c4dca122a91..f0e2cf3c9e89 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -69,7 +69,7 @@
 			label = "user";
 			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x114>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 67659a0ed13e..de5138e61ddc 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -80,7 +80,7 @@
 			label = "user";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x114>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 	};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 4d091ca43e25..5ec6491d7933 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -238,7 +238,7 @@
 		ti,debounce-tol = /bits/ 16 <10>;
 		ti,debounce-rep = /bits/ 16 <1>;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index 9ca2865a83d6..86850bb311eb 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -64,7 +64,7 @@
 			label = "user";
 			gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 			linux,code = <BTN_EXTRA>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index e84184de2a4a..2476d3accee0 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -68,6 +68,6 @@
 		ti,keep-vref-on = <1>;
 		ti,settle-delay-usec = /bits/ 16 <150>;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7166d8876ea8..d780ea16a0a3 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -37,7 +37,7 @@
 			label = "aux";
 			linux,code = <169>;
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index bd6e6769c7ce..3198dafffb7a 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -35,63 +35,63 @@
 			label = "enter";
 			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* gpio101 */
 			linux,code = <KEY_ENTER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_f1 {
 			label = "f1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* gpio102 */
 			linux,code = <KEY_F1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_f2 {
 			label = "f2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>; /* gpio103 */
 			linux,code = <KEY_F2>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_f3 {
 			label = "f3";
 			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>; /* gpio104 */
 			linux,code = <KEY_F3>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_f4 {
 			label = "f4";
 			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>; /* gpio105 */
 			linux,code = <KEY_F4>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_left {
 			label = "left";
 			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>; /* gpio106 */
 			linux,code = <KEY_LEFT>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_right {
 			label = "right";
 			gpios = <&gpio4 11 GPIO_ACTIVE_LOW>; /* gpio107 */
 			linux,code = <KEY_RIGHT>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_up {
 			label = "up";
 			gpios = <&gpio4 12 GPIO_ACTIVE_LOW>; /* gpio108 */
 			linux,code = <KEY_UP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key_down {
 			label = "down";
 			gpios = <&gpio4 13 GPIO_ACTIVE_LOW>; /* gpio109 */
 			linux,code = <KEY_DOWN>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index d0dd0365bfda..f0484cedd0bc 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -327,7 +327,7 @@
 		ti,pressure-max = /bits/ 16 <255>;
 		ti,swap-xy;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5f5e0f3d5b64..c146f42313cb 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -67,28 +67,28 @@
 			gpios = <&gpio4 14 GPIO_ACTIVE_LOW>; /* 110 */
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x09>; /* SW_CAMERA_LENS_COVER */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		camera_focus {
 			label = "Camera Focus";
 			gpios = <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
 			linux,code = <0x210>; /* KEY_CAMERA_FOCUS */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		camera_capture {
 			label = "Camera Capture";
 			gpios = <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
 			linux,code = <0xd4>; /* KEY_CAMERA */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lock_button {
 			label = "Lock Button";
 			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
 			linux,code = <0x98>; /* KEY_SCREENLOCK */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		keypad_slide {
@@ -96,7 +96,7 @@
 			gpios = <&gpio3 7 GPIO_ACTIVE_LOW>; /* 71 */
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x0a>; /* SW_KEYPAD_SLIDE */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		proximity_sensor {
diff --git a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
index 7aae8fb82c1f..3b3a75997f81 100644
--- a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
@@ -48,7 +48,7 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;		/* gpio_10 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
index 17b82f82638a..7df27926ead2 100644
--- a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
@@ -41,13 +41,13 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1 at 14 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index 80d236ac64a5..2bbc2bd30b81 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -161,6 +161,6 @@
 		ti,x-plate-ohms = /bits/ 16 <180>;
 		ti,pressure-max = /bits/ 16 <255>;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
index 048fd216970a..d19a2f293c97 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -172,7 +172,7 @@
 		ti,x-plate-ohms = /bits/ 16 <180>;
 		ti,pressure-max = /bits/ 16 <255>;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi b/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
index 49d2254a99b0..250cc7fe5d5e 100644
--- a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
@@ -41,13 +41,13 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1 at 14 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi b/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
index 680d7262399c..8df7ec35d17d 100644
--- a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
@@ -41,13 +41,13 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1 at 14 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
index 087aedf5b902..0ea2c451c809 100644
--- a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
@@ -41,13 +41,13 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1 at 14 {
 			label = "button1";
 			linux,code = <BTN_1>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index f2084e6d01e7..a5827c7ba1af 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -84,112 +84,112 @@
 			label = "up";
 			linux,code = <KEY_UP>;
 			gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;	/* GPIO_110 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		down-button {
 			label = "down";
 			linux,code = <KEY_DOWN>;
 			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;	/* GPIO_103 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		left-button {
 			label = "left";
 			linux,code = <KEY_LEFT>;
 			gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;	/* GPIO_96 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		right-button {
 			label = "right";
 			linux,code = <KEY_RIGHT>;
 			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;	/* GPIO_98 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		pageup-button {
 			label = "game 1";
 			linux,code = <KEY_PAGEUP>;
 			gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;	/* GPIO_109 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		pagedown-button {
 			label = "game 3";
 			linux,code = <KEY_PAGEDOWN>;
 			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;	/* GPIO_106 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		home-button {
 			label = "game 4";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;	/* GPIO_101 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		end-button {
 			label = "game 2";
 			linux,code = <KEY_END>;
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;	/* GPIO_111 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		right-shift {
 			label = "l";
 			linux,code = <KEY_RIGHTSHIFT>;
 			gpios = <&gpio4 6 GPIO_ACTIVE_LOW>;	/* GPIO_102 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		kp-plus {
 			label = "l2";
 			linux,code = <KEY_KPPLUS>;
 			gpios = <&gpio4 1 GPIO_ACTIVE_LOW>;	/* GPIO_97 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		right-ctrl {
 			label = "r";
 			linux,code = <KEY_RIGHTCTRL>;
 			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;	/* GPIO_105 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		kp-minus {
 			label = "r2";
 			linux,code = <KEY_KPMINUS>;
 			gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;	/* GPIO_107 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		left-ctrl {
 			label = "ctrl";
 			linux,code = <KEY_LEFTCTRL>;
 			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;	/* GPIO_104 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		menu {
 			label = "menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&gpio4 3 GPIO_ACTIVE_LOW>;	/* GPIO_99 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		hold {
 			label = "hold";
 			linux,code = <KEY_COFFEE>;
 			gpios = <&gpio6 16 GPIO_ACTIVE_LOW>;	/* GPIO_176 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		left-alt {
 			label = "alt";
 			linux,code = <KEY_LEFTALT>;
 			gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;	/* GPIO_100 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid {
@@ -617,7 +617,7 @@
 		ti,x-plate-ohms = /bits/ 16 <40>;
 		ti,pressure-max = /bits/ 16 <255>;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 
 	lcd: lcd at 1 {
diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
index f4b1a61853e3..157345bb8e79 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -66,6 +66,6 @@
 		ti,x-plate-ohms = /bits/ 16 <40>;
 		ti,pressure-max = /bits/ 16 <255>;
 		ti,swap-xy;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 1a78f013f37a..ab17b9929250 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -36,7 +36,7 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;	/* gpio_121 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
index f2d2fdb75628..6e278d7716a5 100644
--- a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
+++ b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
@@ -41,7 +41,7 @@
 			label = "user";
 			gpios = <&gpio6 24 GPIO_ACTIVE_HIGH>; /* gpio 184 */
 			linux,code = <BTN_EXTRA>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 61ad2ea34720..95c5523c1230 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -359,7 +359,7 @@
 		ti,debounce-tol = /bits/ 16 <10>;
 		ti,debounce-rep = /bits/ 16 <1>;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
-- 
1.9.1
