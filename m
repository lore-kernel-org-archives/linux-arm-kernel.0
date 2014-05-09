From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  9 May 2014 10:43:07 +0200
Subject: [PATCH] ARM: dts: sun6i-a31-app4-evb1.dts: Use
 sunxi-common-regulators.dtsi
Message-ID: <1399624987-12381-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index 270ab97..2bbf886 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun6i-a31.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
@@ -49,15 +50,8 @@
 	};
 
 	reg_usb1_vbus: usb1-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb1_vbus_pin_a>;
-		regulator-name = "usb1-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
 		gpio = <&pio 7 27 0>;
 		status = "okay";
 	};
-
 };
-- 
1.9.0
