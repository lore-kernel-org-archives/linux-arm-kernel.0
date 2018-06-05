From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  5 Jun 2018 10:52:23 +0200
Subject: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
Message-ID: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
devices on the P212 Reference Design based boards.

Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 0cfd701..a1b3101 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -189,3 +189,10 @@
 &usb0 {
 	status = "okay";
 };
+
+&usb2_phy0 {
+	/*
+	 * HDMI_5V is also used as supply for the USB VBUS.
+	 */
+	phy-supply = <&hdmi_5v>;
+};
-- 
2.7.4
