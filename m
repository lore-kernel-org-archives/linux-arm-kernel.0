From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Dec 2015 23:35:00 +0100
Subject: [PATCH v2 1/3] ARM: dts: sun4i: Add touchscreen node to inet9f-rev03
 tablet dts file
Message-ID: <1450823702-21565-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the focaltech ft5406ee8 touchscreen found on
inet-9f-rev03 / qware qw tb-g100 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop unused pinctrl-names = "default";
---
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index ca49b0d..bba4f9c 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -253,6 +253,15 @@
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
