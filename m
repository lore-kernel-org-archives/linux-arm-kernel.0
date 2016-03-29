From: stefan@agner.ch (Stefan Agner)
Date: Mon, 28 Mar 2016 19:00:02 -0700
Subject: [PATCH v2 8/8] ARM: dts: vf610-colibri: enable display controller
In-Reply-To: <1459216802-32094-1-git-send-email-stefan@agner.ch>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
Message-ID: <1459216802-32094-9-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable dcu node which is used by the DCU DRM driver. Assign the 5.7"
EDT panel with VGA resolution which Toradex sells often with the
evaluation board.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 16 +++++++++++++++
 arch/arm/boot/dts/vf-colibri.dtsi         | 33 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index ed65e0f..f5d4c78 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -18,6 +18,11 @@
 		clock-frequency = <16000000>;
 	};
 
+	panel: panel {
+		compatible = "edt,et057090dhu";
+		backlight = <&bl>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -53,6 +58,13 @@
 	status  = "okay";
 };
 
+&dcu0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dcu0_1>;
+	fsl,panel = <&panel>;
+	status = "okay";
+};
+
 &dspi1 {
 	status = "okay";
 
@@ -100,6 +112,10 @@
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 6e556be..5f1847b 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -159,6 +159,39 @@
 			>;
 		};
 
+		pinctrl_dcu0_1: dcu0grp_1 {
+			fsl,pins = <
+				VF610_PAD_PTE0__DCU0_HSYNC	0x1902
+				VF610_PAD_PTE1__DCU0_VSYNC	0x1902
+				VF610_PAD_PTE2__DCU0_PCLK	0x1902
+				VF610_PAD_PTE4__DCU0_DE		0x1902
+				VF610_PAD_PTE5__DCU0_R0		0x1902
+				VF610_PAD_PTE6__DCU0_R1		0x1902
+				VF610_PAD_PTE7__DCU0_R2		0x1902
+				VF610_PAD_PTE8__DCU0_R3		0x1902
+				VF610_PAD_PTE9__DCU0_R4		0x1902
+				VF610_PAD_PTE10__DCU0_R5	0x1902
+				VF610_PAD_PTE11__DCU0_R6	0x1902
+				VF610_PAD_PTE12__DCU0_R7	0x1902
+				VF610_PAD_PTE13__DCU0_G0	0x1902
+				VF610_PAD_PTE14__DCU0_G1	0x1902
+				VF610_PAD_PTE15__DCU0_G2	0x1902
+				VF610_PAD_PTE16__DCU0_G3	0x1902
+				VF610_PAD_PTE17__DCU0_G4	0x1902
+				VF610_PAD_PTE18__DCU0_G5	0x1902
+				VF610_PAD_PTE19__DCU0_G6	0x1902
+				VF610_PAD_PTE20__DCU0_G7	0x1902
+				VF610_PAD_PTE21__DCU0_B0	0x1902
+				VF610_PAD_PTE22__DCU0_B1	0x1902
+				VF610_PAD_PTE23__DCU0_B2	0x1902
+				VF610_PAD_PTE24__DCU0_B3	0x1902
+				VF610_PAD_PTE25__DCU0_B4	0x1902
+				VF610_PAD_PTE26__DCU0_B5	0x1902
+				VF610_PAD_PTE27__DCU0_B6	0x1902
+				VF610_PAD_PTE28__DCU0_B7	0x1902
+			>;
+		};
+
 		pinctrl_dspi1: dspi1grp {
 			fsl,pins = <
 				VF610_PAD_PTD5__DSPI1_CS0		0x33e2
-- 
2.7.4
