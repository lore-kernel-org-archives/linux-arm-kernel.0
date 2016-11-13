From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Nov 2016 20:22:03 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: reference-design-tablet: ldo_io1 is
 vcc-touchscreen
In-Reply-To: <20161113192203.7101-1-hdegoede@redhat.com>
References: <20161113192203.7101-1-hdegoede@redhat.com>
Message-ID: <20161113192203.7101-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some Q8 and other tablets ldo_io1 is used as vcc-touchscreen,
config at as such in sun8i-reference-design-tablet.dtsi.

Note that it will only be enabled when it us actually referenced by
a foo-supply property in the touchscreen node, so for tablets which
do not use ldo_io1 as vcc-touchscreen, it will be disabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts | 7 -------
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi  | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
index a86cbed..21bb291 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -98,13 +98,6 @@
 	};
 };
 
-&reg_ldo_io1 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-touchscreen";
-	status = "okay";
-};
-
 &touchscreen {
 	reg = <0x40>;
 	compatible = "silead,gsl1680";
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 08cd001..69bc0cd 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -209,6 +209,13 @@
 	status = "okay";
 };
 
+&reg_ldo_io1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-touchscreen";
+	status = "okay";
+};
+
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
-- 
2.9.3
