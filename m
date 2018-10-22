From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Mon, 22 Oct 2018 12:33:18 +0200
Subject: [PATCH 1/2] ARM: dts: ccimx6ulsbcpro: Add support for AUO G101EVN010
 display
In-Reply-To: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
References: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
Message-ID: <1540204399-12982-2-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index 11966d12af76..ac9ae4ac77ba 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -111,7 +111,32 @@
 		     &pinctrl_lcdif_clken
 		     &pinctrl_lcdif_hvsync>;
 	lcd-supply = <&ldo4_ext>;       /* BU90T82 LVDS bridge power */
+	display = <&g101evn010>;
 	status = "okay";
+
+	g101evn010: display at 0 {
+		bits-per-pixel = <16>;
+		bus-width = <18>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <68930000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hfront-porch = <120>;
+				hback-porch = <0>;
+				hsync-len = <8>;
+				vback-porch = <10>;
+				vfront-porch = <0>;
+				vsync-len = <6>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
 };
 
 &ldo4_ext {
