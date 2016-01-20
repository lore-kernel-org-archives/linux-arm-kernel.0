From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 14:09:20 +0100
Subject: [PATCH 2/4] ARM: dts: imx53: fix LVDS data-mapping and data-width
In-Reply-To: <1453295362-18798-1-git-send-email-LW@KARO-electronics.de>
References: <1453295362-18798-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453295362-18798-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 6480471..6d0b526 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -183,13 +183,14 @@
 	status = "okay";
 
 	lvds0: lvds-channel at 0 {
-		fsl,data-mapping = "jeida";
-		fsl,data-width = <24>;
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
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
@@ -208,13 +209,14 @@
 	};
 
 	lvds1: lvds-channel at 1 {
-		fsl,data-mapping = "jeida";
-		fsl,data-width = <24>;
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
 		status = "okay";
 
 		display-timings {
-			native-mode = <&lvds_timing1>;
-			lvds_timing1: hsd100pxn1 {
+			native-mode = <&lvds1_timing0>;
+
+			lvds1_timing0: hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
-- 
2.1.4
