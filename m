From: peda@axentia.se (Peter Rosin)
Date: Thu, 18 Jan 2018 12:46:15 +0100
Subject: [PATCH v2 2/3] ARM: dts: at91: nattis: add lvds-encoder
In-Reply-To: <20180118114616.6639-1-peda@axentia.se>
References: <20180118114616.6639-1-peda@axentia.se>
Message-ID: <20180118114616.6639-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lvds encoder chip was omitted by oversight. Add it.

Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 31 ++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 03683c1b4240..7cedd3ddf0bd 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -109,7 +109,32 @@
 
 		port {
 			panel_input: endpoint {
-				remote-endpoint = <&hlcdc_panel_output>;
+				remote-endpoint = <&lvds_encoder_output>;
+			};
+		};
+	};
+
+	lvds-encoder {
+		compatible = "lvds-encoder";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				lvds_encoder_input: endpoint {
+					remote-endpoint = <&hlcdc_output>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				lvds_encoder_output: endpoint {
+					remote-endpoint = <&panel_input>;
+				};
 			};
 		};
 	};
@@ -176,8 +201,8 @@
 			     &pinctrl_lcd_hipow0>;
 
 		port at 0 {
-			hlcdc_panel_output: endpoint {
-				remote-endpoint = <&panel_input>;
+			hlcdc_output: endpoint {
+				remote-endpoint = <&lvds_encoder_input>;
 			};
 		};
 	};
-- 
2.11.0
