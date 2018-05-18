From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:03 +0200
Subject: [PATCH 041/102] arm64: dts: renesas: condor: add EtherAVB pins
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <55cda28160e1ea852955ee17464d0dccfa67fa72.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the (previously omitted) EtherAVB pin data to the Condor board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index 38f11cee42dc..7af5afa41795 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -30,6 +30,9 @@
 };
 
 &avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+
 	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 	renesas,no-ether-link;
@@ -50,6 +53,11 @@
 };
 
 &pfc {
+	avb_pins: avb {
+		groups = "avb_mdio", "avb_rgmii";
+		function = "avb";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
-- 
2.11.0
