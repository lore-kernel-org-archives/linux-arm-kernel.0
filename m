From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:00 +0200
Subject: [PATCH 038/102] arm64: dts: renesas: v3msk: add EtherAVB pins
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <68d3b03fcb5a2e7c71b1e72c6d856e6030c4f2fd.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the (previously omitted) EtherAVB pin data to the V3M Starter Kit
board's device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index a8ceeac77992..55aa01b663e5 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -32,6 +32,9 @@
 };
 
 &avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+
 	renesas,no-ether-link;
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
@@ -52,6 +55,11 @@
 };
 
 &pfc {
+	avb_pins: avb0 {
+		groups = "avb0_mdio", "avb0_rgmii", "avb0_txcrefclk";
+		function = "avb0";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
-- 
2.11.0
