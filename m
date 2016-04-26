From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 25 Apr 2016 18:09:33 -0700
Subject: [PATCH] ARM: dts: imx6: fix dtc warnings for ipu endpoints
Message-ID: <1461632973-10487-1-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiled with "W=1", dtc complains: e.g.
"Warning (unit_address_vs_reg):
Node /soc/ipu at 02800000/port at 2/endpoint at 0
has a unit name, but no reg property"

Endpoint nodes don't have a reg property, and the addresses
in their node names are ordinals without any special meaning
so remove them and swap them for semantic node names.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6q.dtsi   | 18 +++++++++---------
 arch/arm/boot/dts/imx6qdl.dtsi | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cd10c8d..c30c836 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -154,22 +154,22 @@
 				#size-cells = <0>;
 				reg = <2>;
 
-				ipu2_di0_disp0: endpoint at 0 {
+				ipu2_di0_disp0: disp0-endpoint {
 				};
 
-				ipu2_di0_hdmi: endpoint at 1 {
+				ipu2_di0_hdmi: hdmi-endpoint {
 					remote-endpoint = <&hdmi_mux_2>;
 				};
 
-				ipu2_di0_mipi: endpoint at 2 {
+				ipu2_di0_mipi: mipi-endpoint {
 					remote-endpoint = <&mipi_mux_2>;
 				};
 
-				ipu2_di0_lvds0: endpoint at 3 {
+				ipu2_di0_lvds0: lvds0-endpoint {
 					remote-endpoint = <&lvds0_mux_2>;
 				};
 
-				ipu2_di0_lvds1: endpoint at 4 {
+				ipu2_di0_lvds1: lvds1-endpoint {
 					remote-endpoint = <&lvds1_mux_2>;
 				};
 			};
@@ -179,19 +179,19 @@
 				#size-cells = <0>;
 				reg = <3>;
 
-				ipu2_di1_hdmi: endpoint at 1 {
+				ipu2_di1_hdmi: hdmi-endpoint {
 					remote-endpoint = <&hdmi_mux_3>;
 				};
 
-				ipu2_di1_mipi: endpoint at 2 {
+				ipu2_di1_mipi: mipi-endpoint {
 					remote-endpoint = <&mipi_mux_3>;
 				};
 
-				ipu2_di1_lvds0: endpoint at 3 {
+				ipu2_di1_lvds0: lvds0-endpoint {
 					remote-endpoint = <&lvds0_mux_3>;
 				};
 
-				ipu2_di1_lvds1: endpoint at 4 {
+				ipu2_di1_lvds1: lvds1-endpoint {
 					remote-endpoint = <&lvds1_mux_3>;
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b42822a..294afa7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1230,22 +1230,22 @@
 				#size-cells = <0>;
 				reg = <2>;
 
-				ipu1_di0_disp0: endpoint at 0 {
+				ipu1_di0_disp0: disp0-endpoint {
 				};
 
-				ipu1_di0_hdmi: endpoint at 1 {
+				ipu1_di0_hdmi: hdmi-endpoint {
 					remote-endpoint = <&hdmi_mux_0>;
 				};
 
-				ipu1_di0_mipi: endpoint at 2 {
+				ipu1_di0_mipi: mipi-endpoint {
 					remote-endpoint = <&mipi_mux_0>;
 				};
 
-				ipu1_di0_lvds0: endpoint at 3 {
+				ipu1_di0_lvds0: lvds0-endpoint {
 					remote-endpoint = <&lvds0_mux_0>;
 				};
 
-				ipu1_di0_lvds1: endpoint at 4 {
+				ipu1_di0_lvds1: lvds1-endpoint {
 					remote-endpoint = <&lvds1_mux_0>;
 				};
 			};
@@ -1255,22 +1255,22 @@
 				#size-cells = <0>;
 				reg = <3>;
 
-				ipu1_di0_disp1: endpoint at 0 {
+				ipu1_di0_disp1: disp1-endpoint {
 				};
 
-				ipu1_di1_hdmi: endpoint at 1 {
+				ipu1_di1_hdmi: hdmi-endpoint {
 					remote-endpoint = <&hdmi_mux_1>;
 				};
 
-				ipu1_di1_mipi: endpoint at 2 {
+				ipu1_di1_mipi: mipi-endpoint {
 					remote-endpoint = <&mipi_mux_1>;
 				};
 
-				ipu1_di1_lvds0: endpoint at 3 {
+				ipu1_di1_lvds0: lvds0-endpoint {
 					remote-endpoint = <&lvds0_mux_1>;
 				};
 
-				ipu1_di1_lvds1: endpoint at 4 {
+				ipu1_di1_lvds1: lvds1-endpoint {
 					remote-endpoint = <&lvds1_mux_1>;
 				};
 			};
-- 
2.8.1
