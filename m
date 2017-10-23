From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Oct 2017 22:21:56 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun8i: a711: Enable USB OTG
In-Reply-To: <d359767ec98f4740a416a3eb322a691830aa37a8.1508790064.git-series.maxime.ripard@free-electrons.com>
References: <d359767ec98f4740a416a3eb322a691830aa37a8.1508790064.git-series.maxime.ripard@free-electrons.com>
Message-ID: <819a4ac0ceae513a5ba0df8fa0a3516edfcaa144.1508790064.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TBS A711 has a micro-USB connector that can be used in OTG mode. Enable
it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 786937a3af78..94fb01564304 100644
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
