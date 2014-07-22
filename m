From: marek@goldelico.com (Marek Belisko)
Date: Tue, 22 Jul 2014 21:30:20 +0200
Subject: [PATCH v2 7/7] arm: dts: omap3-gta04: Add twl4030 regulators
 parameters
In-Reply-To: <1406057420-22269-1-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Message-ID: <1406057420-22269-8-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define voltages and properties for various twl4030
regulators used on gta04 board.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 05fd4d2..e39ede2 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -346,11 +346,37 @@
 	bb_uamp = <150>;
 };
 
+/* spare */
+&vaux1 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <3000000>;
+};
+
+/* sensors */
+&vaux2 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-always-on;
+};
+
+/* camera */
+&vaux3 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+};
+
+/* WLAN/BT */
 &vaux4 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <3150000>;
 };
 
+/* GPS LNA */
+&vsim {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <3150000>;
+};
+
 /* Needed to power the DPI pins */
 &vpll2 {
 	regulator-always-on;
-- 
1.9.1
