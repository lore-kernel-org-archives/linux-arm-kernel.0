From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 10 May 2014 11:34:03 +0200
Subject: [PATCH v11 6/6] ARM: dts: sun7i: Add reg_vmmc0 to sun7i boards
In-Reply-To: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399714443-12459-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 5 +++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 5 +++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 3918e2f..d8f8565 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -23,6 +23,7 @@
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -116,6 +117,10 @@
 		status = "okay";
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 9dbb763c..1320078 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -23,6 +23,7 @@
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -175,6 +176,10 @@
 		status = "okay";
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_vmmc3: vmmc3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 1bfef12..f735348 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -34,6 +34,7 @@
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 1 0>; /* PH1 */
 			cd-inverted;
@@ -163,6 +164,10 @@
 		status = "okay";
 	};
 
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
-- 
1.9.0
