From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Dec 2015 23:35:02 +0100
Subject: [PATCH v2 3/3] ARM: dts: sun4i: Add touchscreen node to inet97fv2 dts
 file
In-Reply-To: <1450823702-21565-1-git-send-email-hdegoede@redhat.com>
References: <1450823702-21565-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1450823702-21565-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the focaltech ft5306de4 touchscreen found on
inet97fv2 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop unused pinctrl-names = "default";
---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 77c31da..04b0d2d 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -48,6 +48,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "INet-97F Rev 02";
@@ -93,6 +94,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
 	status = "okay";
+
+	ft5406ee8: touchscreen at 38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+	};
 };
 
 &lradc {
-- 
2.5.0
