From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sun,  6 Oct 2013 13:48:52 +0200
Subject: [PATCH] ARM: imx51-apf51dev: Add parallel display support
Message-ID: <1381060132-30340-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx51-apf51dev.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 123fe84..5a7f552 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -16,6 +16,33 @@
 	model = "Armadeus Systems APF51Dev docking/development board";
 	compatible = "armadeus,imx51-apf51dev", "armadeus,imx51-apf51", "fsl,imx51";
 
+	display at di1 {
+		compatible = "fsl,imx-parallel-display";
+		crtcs = <&ipu 0>;
+		interface-pix-fmt = "bgr666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu_disp1_1>;
+
+		display-timings {
+			lw700 {
+				native-mode;
+				clock-frequency = <33000033>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <96>;
+				hfront-porch = <96>;
+				vback-porch = <20>;
+				vfront-porch = <21>;
+				hsync-len = <64>;
+				vsync-len = <4>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
1.8.1.5
