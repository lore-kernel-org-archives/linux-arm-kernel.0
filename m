From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Sep 2016 20:23:24 +0200
Subject: [PATCH 2/5] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-inet86dz
In-Reply-To: <20160911182327.824-1-hdegoede@redhat.com>
References: <20160911182327.824-1-hdegoede@redhat.com>
Message-ID: <20160911182327.824-3-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inet86dz tablet has a gsl1680 touchscreen,
add a dt node describing it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-inet86dz.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-inet86dz.dts b/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
index 0f9f71b..d440575 100644
--- a/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
+++ b/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
@@ -53,6 +53,15 @@
 	status = "okay";
 };
 
+&touchscreen {
+	reg = <0x40>;
+	compatible = "silead,gsl1680";
+	firmware-name = "gsl1680-inet86dz.fw";
+	touchscreen-size-x = <960>;
+	touchscreen-size-y = <640>;
+	status = "okay";
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_dldo1>;
 };
-- 
2.9.3
