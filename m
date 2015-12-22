From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Dec 2015 23:35:01 +0100
Subject: [PATCH v2 2/3] ARM: dts: sun4i: Add touchscreen node to chuwi-v7 dts
 file
In-Reply-To: <1450823702-21565-1-git-send-email-hdegoede@redhat.com>
References: <1450823702-21565-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1450823702-21565-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the focaltech ft5306de4 touchscreen found on
chuwi-v7-cw0825 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop unused pinctrl-names = "default";
---
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
index 5366089..023b03e 100644
--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
@@ -45,6 +45,7 @@
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Chuwi V7 CW0825";
@@ -88,6 +89,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
 	status = "okay";
+
+	ft5306de4: touchscreen at 38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <768>;
+	};
 };
 
 &lradc {
-- 
2.5.0
