From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 28 Feb 2018 18:32:47 +0900
Subject: [PATCH] arm64: dts: uniphier: add fixed regulators for audio codec
Message-ID: <20180228093247.29648-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds regulators that have fixed voltage for audio codec
on UniPhier LD11/20 Global boards. This patch fixes warnings about
TAS57xx audio codec such as "tas571x 0-001b: 0-001b supply AVDD
not found, using dummy regulator".

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11-global.dts     | 21 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts     | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 6bfd1ccd1f71..71eb46a5bd48 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -39,6 +39,20 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
+	dvdd_reg: reg-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "DVDD";
+                regulator-min-microvolt = <3300000>;
+                regulator-max-microvolt = <3300000>;
+	};
+
+	amp_vcc_reg: reg-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "AMP_VCC";
+                regulator-min-microvolt = <24000000>;
+                regulator-max-microvolt = <24000000>;
+	};
+
 	sound {
 		compatible = "audio-graph-card";
 		label = "UniPhier LD11";
@@ -104,6 +118,13 @@
 		pdn-gpios = <&gpio UNIPHIER_GPIO_PORT(23, 5) GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 
+		AVDD-supply = <&dvdd_reg>;
+		DVDD-supply = <&dvdd_reg>;
+		PVDD_A-supply = <&amp_vcc_reg>;
+		PVDD_B-supply = <&amp_vcc_reg>;
+		PVDD_C-supply = <&amp_vcc_reg>;
+		PVDD_D-supply = <&amp_vcc_reg>;
+
 		port at 0 {
 			tas_speaker: endpoint {
 				remote-endpoint = <&i2s_hpcmout1>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 57b1e36b5eaf..eed6346497d2 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -39,6 +39,20 @@
 		reg = <0 0x80000000 0 0xc0000000>;
 	};
 
+	dvdd_reg: reg-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "DVDD";
+                regulator-min-microvolt = <3300000>;
+                regulator-max-microvolt = <3300000>;
+	};
+
+	amp_vcc_reg: reg-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "AMP_VCC";
+                regulator-min-microvolt = <12000000>;
+                regulator-max-microvolt = <12000000>;
+	};
+
 	sound {
 		compatible = "audio-graph-card";
 		label = "UniPhier LD20";
@@ -104,6 +118,13 @@
 		pdn-gpios = <&gpio UNIPHIER_GPIO_PORT(0, 1) GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 
+		AVDD-supply = <&dvdd_reg>;
+		DVDD-supply = <&dvdd_reg>;
+		PVDD_A-supply = <&amp_vcc_reg>;
+		PVDD_B-supply = <&amp_vcc_reg>;
+		PVDD_C-supply = <&amp_vcc_reg>;
+		PVDD_D-supply = <&amp_vcc_reg>;
+
 		port at 0 {
 			tas_speaker: endpoint {
 				remote-endpoint = <&i2s_hpcmout1>;
-- 
2.16.1
