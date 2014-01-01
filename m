From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Jan 2014 20:30:09 +0100
Subject: [PATCH 3/4] ARM: dts: sun5i: Add lradc node
In-Reply-To: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1388604610-20380-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 7 +++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 7 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                 | 7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index e53fb12..c32162e 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -75,6 +75,13 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			allwinner,chan0-step = <200>;
+			/* KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME */
+			allwinner,chan0-keycodes = <115 114 139 28 102>;
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 34dd303..8775bad 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -404,6 +404,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun4i-sid";
 			reg = <0x01c23800 0x10>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index ab566f7..ce31361 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -55,6 +55,13 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			allwinner,chan0-step = <200>;
+			/* KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME */
+			allwinner,chan0-keycodes = <115 114 139 28 102>;
+			status = "okay";
+		};
+
 		uart1: serial at 01c28400 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins_b>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 264cfa4..90c1ed3 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -362,6 +362,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun4i-sid";
 			reg = <0x01c23800 0x10>;
-- 
1.8.4.2
