From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 23 Apr 2015 18:36:48 +0200
Subject: [PATCH] ARM: dts: sun5i: Utoo P66 add uart node and aliases
Message-ID: <1429807008-7041-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like on most non devel-boards it is still possible to get an uart on
the Utoo P66 tablet by soldering some wires to the right pads on the PCB,
add support for this to the dts, like we do with all sunxi boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 00bdf28..bb8d61a 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -57,6 +57,14 @@
 	model = "Utoo P66";
 	compatible = "utoo,p66", "allwinner,sun5i-a13";
 
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	i2c_lcd: i2c at 0 {
 		/* The lcd panel i2c interface is hooked up via gpios */
 		compatible = "i2c-gpio";
@@ -238,6 +246,12 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_b>;
+	status = "okay";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.3.5
