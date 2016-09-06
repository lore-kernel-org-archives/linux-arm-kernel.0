From: stefan@agner.ch (Stefan Agner)
Date: Tue,  6 Sep 2016 11:46:57 -0700
Subject: [PATCH] ARM: dts: vf610-colibri: use of_graph dt nodes to describe
 the panel
Message-ID: <20160906184657.21297-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fsl,panel property is deprecated and we should use the new
of_graph dt bindings to describe the relationship between the DCU
controller and the panel.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index a8a8e43..1e0b823 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -53,6 +53,12 @@
 	panel: panel {
 		compatible = "edt,et057090dhu";
 		backlight = <&bl>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dcu_out>;
+			};
+		};
 	};
 
 	reg_3v3: regulator-3v3 {
@@ -91,8 +97,13 @@
 &dcu0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_dcu0_1>;
-	fsl,panel = <&panel>;
 	status = "okay";
+
+	port {
+		dcu_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 };
 
 &dspi1 {
-- 
2.9.3
