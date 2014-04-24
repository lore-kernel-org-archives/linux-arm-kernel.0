From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 24 Apr 2014 15:07:27 -0700
Subject: [PATCH 3/3] ARM: dts: imx: Fix LVDS mapping for Ventana GW52xx
In-Reply-To: <1398377247-3901-1-git-send-email-tharvey@gateworks.com>
References: <1398377247-3901-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1398377247-3901-4-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW52xx supports LVDS on channel 0. Remove the obsolete crtcs node and
add display timings for the HanStar HSD100PXN1 display.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 9c9259b..735e8e3 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -455,8 +455,26 @@
 
 &ldb {
 	status = "okay";
+
 	lvds-channel at 0 {
-		crtcs = <&ipu1 0>, <&ipu1 1>;
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+			};
+		};
 	};
 };
 
-- 
1.8.3.2
