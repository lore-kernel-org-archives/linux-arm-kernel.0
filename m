From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 19 Mar 2014 14:28:39 +0100
Subject: [PATCH 3/5] ARM: dts: tx53: fix LVDS display mappings
In-Reply-To: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1395235721-13847-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The data-mapping and data-width settings were opposite of what the
display requires. Interestingly, these settings nevertheless produced
correct results.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index cd3476b..26b918e 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -181,8 +181,8 @@
 	status = "okay";
 
 	lvds0: lvds-channel at 0 {
-		fsl,data-mapping = "jeida";
-		fsl,data-width = <24>;
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
 		status = "okay";
 
 		display-timings {
@@ -206,8 +206,8 @@
 	};
 
 	lvds1: lvds-channel at 1 {
-		fsl,data-mapping = "jeida";
-		fsl,data-width = <24>;
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
 		status = "okay";
 
 		display-timings {
-- 
1.7.10.4
