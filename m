From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 19:01:50 +0100
Subject: [PATCH 3/3] ARM: dts: imx6: add display timing for NL12880BC20
 display to Ka-Ro electronics TX6 LVDS modules
In-Reply-To: <1452621710-15336-3-git-send-email-LW@KARO-electronics.de>
References: <1452621710-15336-1-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-2-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452621710-15336-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the NLT Technologies WXGA LVDS display NL12880BC20 to
the TX6 LVDS modules from Ka-Ro electronics.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts | 42 ++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/imx6q-tx6q-1110.dts  | 42 ++++++++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
index c275eec..c14ee8f 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
@@ -104,8 +104,9 @@
 		status = "okay";
 
 		display-timings {
-			native-mode = <&lvds_timing0>;
-			lvds_timing0: hsd100pxn1 {
+			native-mode = <&lvds0_timing0>;
+
+			lvds0_timing0: hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
@@ -118,6 +119,22 @@
 				de-active = <1>;
 				pixelclk-active = <1>;
 			};
+
+			lvds0_timing1: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hsync-len = <60>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vsync-len = <13>;
+				vfront-porch = <5>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
 		};
 	};
 
@@ -127,8 +144,9 @@
 		status = "disabled";
 
 		display-timings {
-			native-mode = <&lvds_timing1>;
-			lvds_timing1: hsd100pxn1 {
+			native-mode = <&lvds1_timing0>;
+
+			lvds1_timing0: hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
@@ -141,6 +159,22 @@
 				de-active = <1>;
 				pixelclk-active = <1>;
 			};
+
+			lvds1_timing1: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hsync-len = <60>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vsync-len = <13>;
+				vfront-porch = <5>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
index 88aa1e4..7a8be02 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1110.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
@@ -104,8 +104,9 @@
 		status = "okay";
 
 		display-timings {
-			native-mode = <&lvds_timing0>;
-			lvds_timing0: hsd100pxn1 {
+			native-mode = <&lvds0_timing0>;
+
+			lvds0_timing0: hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
@@ -118,6 +119,22 @@
 				de-active = <1>;
 				pixelclk-active = <1>;
 			};
+
+			lvds0_timing1: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hsync-len = <60>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vsync-len = <13>;
+				vfront-porch = <5>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
 		};
 	};
 
@@ -127,8 +144,9 @@
 		status = "disabled";
 
 		display-timings {
-			native-mode = <&lvds_timing1>;
-			lvds_timing1: hsd100pxn1 {
+			native-mode = <&lvds1_timing0>;
+
+			lvds1_timing0: hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
@@ -141,6 +159,22 @@
 				de-active = <1>;
 				pixelclk-active = <1>;
 			};
+
+			lvds1_timing1: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hsync-len = <60>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vsync-len = <13>;
+				vfront-porch = <5>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
 		};
 	};
 };
-- 
2.1.4
