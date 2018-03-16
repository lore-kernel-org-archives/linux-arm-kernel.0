From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:56 +0100
Subject: [PATCH 26/69] arm64: dts: renesas: r8a77995: add DU support
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <18f1a773e3f9e6d1eb5549d98bae6f2959edecf2.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Define the generic r8a77995 part of the DU device node.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 621cf30e521d..bcf737a20636 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -748,6 +748,41 @@
 			resets = <&cpg 602>;
 			iommus = <&ipmmu_vi0 9>;
 		};
+
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a77995";
+			reg = <0 0xfeb00000 0 0x80000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>;
+			clock-names = "du.0", "du.1";
+			vsps = <&vspd0 0 &vspd1 0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					du_out_lvds0: endpoint {
+					};
+				};
+
+				port at 2 {
+					reg = <2>;
+					du_out_lvds1: endpoint {
+					};
+				};
+			};
+		};
 	};
 
 	timer {
-- 
2.11.0
