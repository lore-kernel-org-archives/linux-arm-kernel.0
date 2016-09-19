From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 19 Sep 2016 12:39:25 +0200
Subject: [PATCH] ARM: dts: sun8i: Add accelerometer to polaroid-mid2407pxe03
Message-ID: <20160919103925.25149-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dt node describing the mma7660 accelerometer on the
polaroid-mid2407pxe03 tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
index 6662127..a86cbed 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -62,6 +62,13 @@
 	};
 };
 
+&i2c1 {
+	mma7660: accelerometer at 4c {
+		reg = <0x4c>;
+		compatible = "fsl,mma7660";
+	};
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_a>;
-- 
2.9.3
