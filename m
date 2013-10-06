From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sun,  6 Oct 2013 16:07:54 +0200
Subject: [PATCH] ARM: imx27-apf27dev: Add framebuffer support
Message-ID: <1381068474-30763-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 2a377ca..47c8c26 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -16,6 +16,26 @@
 	model = "Armadeus Systems APF27Dev docking/development board";
 	compatible = "armadeus,imx27-apf27dev", "armadeus,imx27-apf27", "fsl,imx27";
 
+	display: display {
+		model = "Chimei-LW700AT9003";
+		native-mode = <&timing0>;
+		bits-per-pixel = <16>;  /* non-standard but required */
+		fsl,pcr = <0xfae80083>;	/* non-standard but required */
+		display-timings {
+			timing0: 640x480 {
+				clock-frequency = <33000033>;
+				hactive = <800>;
+				vactive = <640>;
+				hback-porch = <96>;
+				hfront-porch = <96>;
+				vback-porch = <20>;
+				vfront-porch = <21>;
+				hsync-len = <64>;
+				vsync-len = <4>;
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -50,6 +70,12 @@
 	status = "okay";
 };
 
+&fb {
+	display = <&display>;
+	fsl,dmacr = <0x00020010>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	status = "okay";
-- 
1.8.1.5
