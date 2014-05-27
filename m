From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 27 May 2014 17:26:37 +0200
Subject: [PATCH] ARM: dts: imx6qdl: Add CSI device tree port nodes for IPU1
 and IPU2
Message-ID: <1401204397-24592-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CSI subnodes for IPU1 and IPU2 that will contain
ports and endpoints connecting to external elements in the video
pipeline.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fcfbac2..919a18a 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -157,6 +157,14 @@
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
 
+			ipu2_csi0: port at 0 {
+				reg = <0>;
+			};
+
+			ipu2_csi1: port at 1 {
+				reg = <1>;
+			};
+
 			ipu2_di0: port at 2 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 43a10e3..8fba7fc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1038,6 +1038,14 @@
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
 
+			ipu1_csi0: port at 0 {
+				reg = <0>;
+			};
+
+			ipu1_csi1: port at 1 {
+				reg = <1>;
+			};
+
 			ipu1_di0: port at 2 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.0.0.rc2
