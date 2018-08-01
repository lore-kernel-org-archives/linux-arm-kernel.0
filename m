From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  1 Aug 2018 15:40:32 +0200
Subject: [PATCH v2 2/3] arm64: dts: meson-axg: s400: enable audio devices
In-Reply-To: <20180801134033.21739-1-jbrunet@baylibre.com>
References: <20180801134033.21739-1-jbrunet@baylibre.com>
Message-ID: <20180801134033.21739-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the audio devices on the s400.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d5c01427a5ca..9f5d81c3ee29 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -226,6 +226,18 @@
 	};
 };
 
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>;
@@ -334,3 +346,63 @@
 	status = "okay";
 	vref-supply = <&vddio_ao18>;
 };
+
+&spdifout {
+	pinctrl-0 = <&spdif_out_a20_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tdmin_a {
+	status = "okay";
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&tdmin_c {
+	status = "okay";
+};
+
+&tdmin_lb {
+	status = "okay";
+};
+
+&tdmout_c {
+	status = "okay";
+};
+
+&tdmif_a {
+	pinctrl-0 = <&tdma_sclk_pins>, <&tdma_fs_pins>,
+		    <&tdma_din0_pins>, <&tdma_dout0_x15_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tdmif_b {
+	pinctrl-0 = <&tdmb_sclk_pins>, <&tdmb_fs_pins>,
+		    <&tdmb_din3_pins>, <&mclk_b_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tdmif_c {
+	pinctrl-0 = <&tdmc_sclk_pins>, <&tdmc_fs_pins>,
+		    <&tdmc_din1_pins>, <&tdmc_dout2_pins>,
+		    <&mclk_c_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
-- 
2.17.1
