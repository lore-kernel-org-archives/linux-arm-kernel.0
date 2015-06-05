From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:19 +0200
Subject: [PATCH 16/20] ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A23 tablets
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-17-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg controller on Ippo Q8H tablets, for now it is enabled
in host-only mode, because true OTG support requires support for
detecting and enabling Vbus through the axp221 pmic.

For this to work the Vbus on the port must be enabled by u-boot,
or a powered hub must be used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 95134c6..8d9da68 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -125,3 +125,12 @@
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
