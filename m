From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:59:53 +0200
Subject: [PATCH 4/5] ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A33 tablet
In-Reply-To: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438333194-21181-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg/drc usb controller on the Ippo Q8H-A33 tablet, for now it
is enabled in host-only mode, because true OTG support requires support
for detecting and enabling Vbus through the axp221 pmic.

For this to work the Vbus on the port must be enabled by u-boot,
or a powered hub must be used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts b/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
index 8bb75ee..361ddb9 100644
--- a/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
@@ -116,3 +116,12 @@
 	pinctrl-0 = <&r_uart_pins_a>;
 	status = "okay";
 };
+
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
