From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Jan 2014 20:30:10 +0100
Subject: [PATCH 4/4] ARM: dts: sun7i: Add lradc node
In-Reply-To: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1388604610-20380-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 7 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 0ee2641..dcf9db7 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -86,6 +86,13 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			allwinner,chan0-step = <200>;
+			/* VOLUMEUP VOLUMEDOWN MENU SEARCH HOME ESC ENTER */
+			allwinner,chan0-keycodes = <115 114 139 217 102 1 28>;
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 68e825a..3484275 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -531,6 +531,13 @@
 			interrupts = <0 24 1>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <0 31 4>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
-- 
1.8.4.2
