From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 15 Nov 2015 20:46:17 +0100
Subject: [PATCH 5/5] ARM: dts: sun8i-h3-orangepi-plus: Enable USB host
 controllers
In-Reply-To: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1447616777-24660-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Reinder de Haan <patchesrdh@mveas.com>

Enable the 3 pairs of USB host controllers used on the Orange Pi Plus.

Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index e67df59..e05a409 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -60,6 +60,18 @@
 	};
 };
 
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
@@ -70,8 +82,24 @@
 	status = "okay";
 };
 
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+};
-- 
2.5.0
