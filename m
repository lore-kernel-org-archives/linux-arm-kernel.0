From: clabbe@baylibre.com (Corentin Labbe)
Date: Mon,  9 Jul 2018 15:20:58 +0000
Subject: [PATCH v2 4/4] ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable
 AHCI
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Message-ID: <1531149658-27030-5-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enable the AHCI controller.
Since this controller need two regulator, this patch add them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 4f3d583183dc..ceb38739f1d8 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -105,6 +105,12 @@
 	};
 };
 
+&ahci {
+	vdd1v2-supply = <&reg_dldo4>;
+	vdd2v5-supply = <&reg_eldo3>;
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -251,6 +257,18 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo4 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vdd2v5-sata";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd1v2-sata";
+};
+
 &tcon_top_hdmi_in_tcon_tv0 {
 	remote-endpoint = <&tcon_tv0_out_tcon_top>;
 };
-- 
2.16.4
