From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:25 +0200
Subject: [PATCH 063/102] arm64: dts: renesas: r8a7796: Add address properties
 to rcar_sound port nodes
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <78bc93b3ffb2cd71341a3373fd14b62847091b7e.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rcar_sound port nodes have unit names and thus should have register
properties.

This is flagged by dtc as follows:
 # make dtbs W=1
 ...
 DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (unit_address_vs_reg): /soc/sound at ec500000/ports/port at 0: node has a unit name, but no reg property
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (unit_address_vs_reg): /soc/sound at ec500000/ports/port at 1: node has a unit name, but no reg property
 ...
 DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb
 arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (unit_address_vs_reg): /soc/sound at ec500000/ports/port at 0: node has a unit name, but no reg property
 arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (unit_address_vs_reg): /soc/sound at ec500000/ports/port at 1: node has a unit name, but no reg property

Prior to this patch the port nodes only defined in board DTS files.
As the register properties are common this patch defines the port nodes
and provides register properties in the SoC DTS file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index f41bc25b3933..3fbd86590fb0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1594,6 +1594,17 @@
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port at 0 {
+					reg = <0>;
+				};
+				port at 1 {
+					reg = <1>;
+				};
+			};
 		};
 
 		audma0: dma-controller at ec700000 {
-- 
2.11.0
