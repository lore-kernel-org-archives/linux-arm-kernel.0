From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 10 Dec 2014 16:37:18 +0800
Subject: [PATCH RFC 05/15] ARM: dts: imx6qdl: Add input-port property to MIPI
 DSI node's CTRC child nodes
In-Reply-To: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1418200648-32656-6-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To phase out the MIPI DSI's child nodes which present DRM CRTCs from the
child nodes which represent MIPI DSI peripherals, we need to add input-port
property to the child nodes to be phased out.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi   | 2 ++
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e9f3646..e6a6d90 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -294,6 +294,7 @@
 &mipi_dsi {
 	port at 2 {
 		reg = <2>;
+		input-port;
 
 		mipi_mux_2: endpoint {
 			remote-endpoint = <&ipu2_di0_mipi>;
@@ -302,6 +303,7 @@
 
 	port at 3 {
 		reg = <3>;
+		input-port;
 
 		mipi_mux_3: endpoint {
 			remote-endpoint = <&ipu2_di1_mipi>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9596ed5..5d92ad7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1011,6 +1011,7 @@
 
 				port at 0 {
 					reg = <0>;
+					input-port;
 
 					mipi_mux_0: endpoint {
 						remote-endpoint = <&ipu1_di0_mipi>;
@@ -1019,6 +1020,7 @@
 
 				port at 1 {
 					reg = <1>;
+					input-port;
 
 					mipi_mux_1: endpoint {
 						remote-endpoint = <&ipu1_di1_mipi>;
-- 
2.1.0
