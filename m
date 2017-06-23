From: briannorris@chromium.org (Brian Norris)
Date: Fri, 23 Jun 2017 10:07:35 -0700
Subject: [PATCH 1/3] arm64: dts: rockchip: Update CPU regulator voltage ranges
 for Gru
Message-ID: <20170623170737.46265-1-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Kaehlcke <mka@chromium.org>

Gru derivatives besides Kevin have slightly different voltage ranges for
their CPU regulators. Let's keep the base Gru file accurate and let
Kevin override.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 16 ++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 658bb9dc9dfd..658d63db0d6d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -264,6 +264,26 @@ ap_i2c_dig: &i2c2 {
 	};
 };
 
+&ppvar_bigcpu {
+	regulator-min-microvolt = <798674>;
+	regulator-max-microvolt = <1302172>;
+};
+
+&ppvar_litcpu {
+	regulator-min-microvolt = <799065>;
+	regulator-max-microvolt = <1303738>;
+};
+
+&ppvar_gpu {
+	regulator-min-microvolt = <785782>;
+	regulator-max-microvolt = <1217729>;
+};
+
+&ppvar_centerlogic {
+	regulator-min-microvolt = <800069>;
+	regulator-max-microvolt = <1049692>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&pp1800_ap_io>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index eb5059344023..134afe8495b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -181,8 +181,8 @@
 		/* EC turns on w/ ap_core_en; always on for AP */
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <798674>;
-		regulator-max-microvolt = <1302172>;
+		regulator-min-microvolt = <800107>;
+		regulator-max-microvolt = <1302232>;
 	};
 
 	ppvar_litcpu: ppvar-litcpu {
@@ -202,8 +202,8 @@
 		/* EC turns on w/ ap_core_en; always on for AP */
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <799065>;
-		regulator-max-microvolt = <1303738>;
+		regulator-min-microvolt = <797743>;
+		regulator-max-microvolt = <1307837>;
 	};
 
 	ppvar_gpu: ppvar-gpu {
@@ -223,8 +223,8 @@
 		/* EC turns on w/ ap_core_en; always on for AP */
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <785782>;
-		regulator-max-microvolt = <1217729>;
+		regulator-min-microvolt = <786384>;
+		regulator-max-microvolt = <1217747>;
 	};
 
 	ppvar_centerlogic: ppvar-centerlogic {
@@ -244,8 +244,8 @@
 		/* EC turns on w/ ppvar_centerlogic_en; always on for AP */
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <800069>;
-		regulator-max-microvolt = <1049692>;
+		regulator-min-microvolt = <799434>;
+		regulator-max-microvolt = <1049925>;
 	};
 
 	/* Schematics call this PPVAR even though it's fixed */
-- 
2.13.1.611.g7e3b11ae1-goog
