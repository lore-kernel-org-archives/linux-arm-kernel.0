From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  4 Nov 2016 15:44:39 +0100
Subject: [PATCH] ARM: sun8i: sina33: Enable USB gadget
Message-ID: <20161104144439.4469-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The micro-USB on the SinA33 has a somewhat interesting design in the sense
that it has a micro USB connector, but the VBUS is (supposed to be)
controlled through an (unpopulated) jumper.

Obviously, that doesn't work really well, and only the peripheral mode
really works. Still enable it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index fa8024072025..1c0d98cbd334 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -247,6 +247,11 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usbphy {
 	status = "okay";
 	usb1_vbus-supply = <&reg_vcc5v0>; /* USB1 VBUS is always on */
-- 
2.10.1
