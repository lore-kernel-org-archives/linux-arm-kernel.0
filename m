From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:34 +0200
Subject: [PATCH 3/9] arm64: dts: renesas: r8a77965: Add second port to
 rcar_sound placeholder
In-Reply-To: <cover.1532087303.git.horms+renesas@verge.net.au>
References: <cover.1532087303.git.horms+renesas@verge.net.au>
Message-ID: <485f8b2824ef10f2a7b12d45a3f2b5c943aa1e04.1532087303.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node is just a placeholder but fills that function better if it does
not trigger build warnings. This update satisfies the requirement that
nodes with #address-cells/#size-cells properties have more than one child
node.

This is flagged by dtc as follows:
 # make dtbs W=1
 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning (graph_child_address): /soc/sound at ec500000/ports: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
 arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb: Warning (graph_child_address): /soc/sound at ec500000/ports: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index be8631dff1b4..a37749caf40e 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1269,6 +1269,9 @@
 				port at 0 {
 					reg = <0>;
 				};
+				port at 1 {
+					reg = <1>;
+				};
 			};
 		};
 
-- 
2.11.0
