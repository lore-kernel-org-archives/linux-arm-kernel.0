From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 14 Sep 2016 12:06:08 +0200
Subject: [PATCH 4/4] ARM64: dts: gxbb: add i2c bus
In-Reply-To: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
References: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473847568-20163-5-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for i2c bus on gxbb based platforms.
On the OdroidC2 (I2C A) and P200 (I2C B), the pull-up resistor are
present directly on the board. This indicates that these pins are
dedicated to i2c.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 4f1554a27422..c6d78d3a018f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -180,3 +180,9 @@
 	vmmc-supply = <&vcc3v3>;
 	vqmmc-supply = <&vcc1v8>;
 };
+
+&i2c_A {
+	status = "okay";
+	pinctrl-0 = <&i2c_a_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 62979076e250..03e3d76626dd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -50,3 +50,9 @@
 	compatible = "amlogic,p200", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P200 Development Board";
 };
+
+&i2c_B {
+	status = "okay";
+	pinctrl-0 = <&i2c_b_pins>;
+	pinctrl-names = "default";
+};
-- 
2.7.4
