From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 31 May 2016 16:49:37 +0200
Subject: [PATCH] ARM: dts: imx6: fix IPU1 DI1 node name
Message-ID: <1464706177-30330-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Borleis <jbe@pengutronix.de>

This node describes the DI1 port of IPU, fix the node name to reflect this.
There's currently no user of this node in mainline, so this change should
not break any supported platforms.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 8e67ca27ad79..207b85b91ada 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -93,7 +93,7 @@
 			reg = <0>;
 
 			lcd_display_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp1>;
+				remote-endpoint = <&ipu1_di1_disp1>;
 			};
 		};
 
@@ -210,7 +210,7 @@
 	};
 };
 
-&ipu1_di0_disp1 {
+&ipu1_di1_disp1 {
 	remote-endpoint = <&lcd_display_in>;
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ed613ebe0812..c270dc2c629f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1255,7 +1255,7 @@
 				#size-cells = <0>;
 				reg = <3>;
 
-				ipu1_di0_disp1: disp1-endpoint {
+				ipu1_di1_disp1: disp1-endpoint {
 				};
 
 				ipu1_di1_hdmi: hdmi-endpoint {
-- 
2.8.1
