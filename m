From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Jun 2014 02:22:40 +0200
Subject: [PATCH 2/2] ARM: dts: mx5: Move the display out of soc {} node
In-Reply-To: <1402618960-9735-1-git-send-email-marex@denx.de>
References: <1402618960-9735-1-git-send-email-marex@denx.de>
Message-ID: <1402618960-9735-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the display {} node out of the soc {} node . This just aligns
the DT with other boards, there is no functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 48 ++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 3a04b9e..c4956b0 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -21,33 +21,31 @@
 		      <0xb0000000 0x20000000>;
 	};
 
-	soc {
-		display1: display at di1 {
-			compatible = "fsl,imx-parallel-display";
-			interface-pix-fmt = "bgr666";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_ipu_disp1>;
-
-			display-timings {
-				800x480p60 {
-					native-mode;
-					clock-frequency = <31500000>;
-					hactive = <800>;
-					vactive = <480>;
-					hfront-porch = <40>;
-					hback-porch = <88>;
-					hsync-len = <128>;
-					vback-porch = <33>;
-					vfront-porch = <9>;
-					vsync-len = <3>;
-					vsync-active = <1>;
-				};
+	display1: display at di1 {
+		compatible = "fsl,imx-parallel-display";
+		interface-pix-fmt = "bgr666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu_disp1>;
+
+		display-timings {
+			800x480p60 {
+				native-mode;
+				clock-frequency = <31500000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <40>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				vback-porch = <33>;
+				vfront-porch = <9>;
+				vsync-len = <3>;
+				vsync-active = <1>;
 			};
+		};
 
-			port {
-				display1_in: endpoint {
-					remote-endpoint = <&ipu_di1_disp1>;
-				};
+		port {
+			display1_in: endpoint {
+				remote-endpoint = <&ipu_di1_disp1>;
 			};
 		};
 	};
-- 
2.0.0.rc2
