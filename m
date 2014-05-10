From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 10 May 2014 11:34:01 +0200
Subject: [PATCH v11 4/6] ARM: dts: sun5i: Add reg_vmmc0 to sun5i boards
In-Reply-To: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399714443-12459-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 5 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  | 5 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index de91308..cde617a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -38,6 +38,7 @@
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 6 1 0>; /* PG1 */
 			cd-inverted;
@@ -152,6 +153,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxino_m>;
 		gpio = <&pio 1 10 0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 8515f19..3fdfb60 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -24,6 +24,7 @@
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 6 0 0>; /* PG0 */
 			cd-inverted;
@@ -103,6 +104,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
 		gpio = <&pio 6 11 0>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 51a9438..a4e22b9 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -23,6 +23,7 @@
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 6 0 0>; /* PG0 */
 			cd-inverted;
@@ -101,6 +102,10 @@
 		};
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxino>;
 		gpio = <&pio 6 11 0>;
-- 
1.9.0
