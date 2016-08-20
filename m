From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 Aug 2016 11:54:24 +0200
Subject: [PATCH v5 6/6] ARM64: dts: meson-gxbb: Enable the the IR decoder on
 supported boards
In-Reply-To: <20160820095424.636-1-martin.blumenstingl@googlemail.com>
References: <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
 <20160820095424.636-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160820095424.636-7-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Infrared Remote Controller on boards which have an Infrared
receiver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index cba3ea1..d4823f4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -161,3 +161,9 @@
 	vmmc-supply = <&vcc3v3>;
 	vmmcq-sumpply = <&vcc1v8>;
 };
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index e118754..4538e5a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -143,3 +143,9 @@
 	vmmc-supply = <&vcc_3v3>;
 	vmmcq-sumpply = <&vddio_boot>;
 };
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 54bb7c7..560770e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -60,3 +60,9 @@
 	pinctrl-names = "default";
 
 };
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
-- 
2.9.3
