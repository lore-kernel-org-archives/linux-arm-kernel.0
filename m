From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 14:53:38 +0200
Subject: [PATCH v2 3/3] ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A33 tablet
In-Reply-To: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
References: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438347218-8158-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg/drc usb controller on the Ippo Q8H-A33 tablet, for now it
is enabled in host-only mode, because true OTG support requires support
for detecting and enabling Vbus through the axp221 pmic.

For this to work the Vbus on the port must be enabled by u-boot,
or a powered hub must be used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a FIXME comment to the usb_otg block in the dts, pointing out the need
 to add full otg support once we get axp22x pmic support for a33 based devices
---
 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
index 8bb75ee..a438975 100644
--- a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
@@ -116,3 +116,18 @@
 	pinctrl-0 = <&r_uart_pins_a>;
 	status = "okay";
 };
+
+/*
+ * FIXME for now we only support host mode and rely on u-boot to have
+ * turned on Vbus which is controlled by the axp223 pmic on the board.
+ *
+ * Once we have axp223 support we should switch to fully supporting otg.
+ */
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.4.3
