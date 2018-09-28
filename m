From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:20:22 +0200
Subject: [PATCH 11/14] arm64: dts: renesas: r8a77995: Add LVDS support
In-Reply-To: <cover.1538125184.git.horms+renesas@verge.net.au>
References: <cover.1538125184.git.horms+renesas@verge.net.au>
Message-ID: <0dc733988b813b4054e2243539855ef535d3c9dd.1538125184.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The r8a77995 D3 platform has 2 LVDS channels connected to the DU.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
[uli: moved lvds* into the soc node, added PM domains, resets]
Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 56 +++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 89a04a4496fd..214f4954b321 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -972,12 +972,68 @@
 				port at 1 {
 					reg = <1>;
 					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
 					};
 				};
 
 				port at 2 {
 					reg = <2>;
 					du_out_lvds1: endpoint {
+						remote-endpoint = <&lvds1_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds-encoder at feb90000 {
+			compatible = "renesas,r8a77995-lvds";
+			reg = <0 0xfeb90000 0 0x20>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 727>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					lvds0_out: endpoint {
+					};
+				};
+			};
+		};
+
+		lvds1: lvds-encoder at feb90100 {
+			compatible = "renesas,r8a77995-lvds";
+			reg = <0 0xfeb90100 0 0x20>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 726>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					lvds1_in: endpoint {
+						remote-endpoint = <&du_out_lvds1>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					lvds1_out: endpoint {
 					};
 				};
 			};
-- 
2.11.0
