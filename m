From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:21 +0200
Subject: [PATCH 18/20] ARM: dts: sun8i: Enable USB DRC on GA10H-A33 tablets
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-19-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg controller on GA10H-A33 tablets, for now it is enabled
in host-only mode, because true OTG support requires support for
detecting and enabling Vbus through the axp221 pmic.

For this to work the Vbus on the port must be enabled by u-boot,
or a powered hub must be used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index 8667033..7520e06 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -123,3 +123,12 @@
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
2.4.2
