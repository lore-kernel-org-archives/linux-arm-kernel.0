From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:26 +0200
Subject: [PATCH 064/102] arm64: dts: renesas: r8a77965: Add address properties
 to rcar_sound port nodes
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <e94ac4c7f4f0b9b2c28cfba3b7c6ba089092a22d.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rcar_sound port nodes have unit names and thus should have register
properties.

This is flagged by dtc as follows:
 # make dtbs W=1
 ...
 DTC     arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning (unit_address_vs_reg): /soc/sound at ec500000/ports/port at 0: node has a unit name, but no reg property
 DTC     arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb: Warning (unit_address_vs_reg): /soc/sound at ec500000/ports/port at 0: node has a unit name, but no reg property

Prior to this patch the port nodes only defined in board DTS files.
As the register properties are common this patch defines the port nodes
and provides register properties in the SoC DTS file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index b46af2744135..7c9555309c0a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -857,6 +857,14 @@
 				ssi1: ssi-1 {
 				};
 			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port at 0 {
+					reg = <0>;
+				};
+			};
 		};
 
 		xhci0: usb at ee000000 {
-- 
2.11.0
