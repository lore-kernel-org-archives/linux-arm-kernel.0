From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Dec 2016 16:57:43 -0800
Subject: [PATCH 02/12] ARM: dts: imx6qdl: rename ipu client nodes
In-Reply-To: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
References: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1481158673-15937-3-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow for IPU client devices that are composed of more than one
port for input and output (SMFC and IC), change the nodes from being
a single port node to nodes that can contain multiple ports. Rename
the nodes to use the following format: "ipu<id>_<subunit>".

The IPUv3 driver will then need to lookup the client nodes by name
rather than by port id.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6q.dtsi   | 12 ++++++------
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e9a5d0b..2b261ba 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -141,18 +141,18 @@
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
 
-			ipu2_csi0: port at 0 {
+			ipu2_csi0: ipu2_csi at 0 {
 				reg = <0>;
 			};
 
-			ipu2_csi1: port at 1 {
+			ipu2_csi1: ipu2_csi at 1 {
 				reg = <1>;
 			};
 
-			ipu2_di0: port at 2 {
+			ipu2_di0: ipu2_di at 0 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <2>;
+				reg = <0>;
 
 				ipu2_di0_disp0: disp0-endpoint {
 				};
@@ -174,10 +174,10 @@
 				};
 			};
 
-			ipu2_di1: port at 3 {
+			ipu2_di1: ipu2_di at 1 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <3>;
+				reg = <1>;
 
 				ipu2_di1_hdmi: hdmi-endpoint {
 					remote-endpoint = <&hdmi_mux_3>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e01e5d5..2465187 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1226,18 +1226,18 @@
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
 
-			ipu1_csi0: port at 0 {
+			ipu1_csi0: ipu1_csi at 0 {
 				reg = <0>;
 			};
 
-			ipu1_csi1: port at 1 {
+			ipu1_csi1: ipu1_csi at 1 {
 				reg = <1>;
 			};
 
-			ipu1_di0: port at 2 {
+			ipu1_di0: ipu1_di at 0 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <2>;
+				reg = <0>;
 
 				ipu1_di0_disp0: disp0-endpoint {
 				};
@@ -1259,10 +1259,10 @@
 				};
 			};
 
-			ipu1_di1: port at 3 {
+			ipu1_di1: ipu1_di at 1 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <3>;
+				reg = <1>;
 
 				ipu1_di1_disp1: disp1-endpoint {
 				};
-- 
2.7.4
