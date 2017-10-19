From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 19 Oct 2017 12:31:09 +0200
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: fix usb1 power supply
Message-ID: <1508409069-6317-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looking at the schematics, the USB Power Supply is shared between the
two USB interfaces,
If the usb0 fails to initialize, the second one won't have power.

Fixes: 5a0803bd5ae2 ("ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1deaa53..2e5ed59 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -301,6 +301,7 @@
 
 &usb1_phy {
 	status = "okay";
+	phy-supply = <&usb_otg_pwr>;
 };
 
 &usb0 {
-- 
2.7.4
