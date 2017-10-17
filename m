From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:29 +0200
Subject: [PATCH 22/23] arm: dts: sun8i: a711: Enable USB OTG
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <95434e5704d3cf721f011de76526575222e58bd6.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 98dc0c22160b..e4d08bff3158 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -337,7 +337,14 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus_supply = <&reg_vmain>;
 	usb2_vbus_supply = <&reg_vmain>;
 	status = "okay";
-- 
git-series 0.9.1
