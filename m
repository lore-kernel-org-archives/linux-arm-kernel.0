From: clabbe@baylibre.com (Corentin Labbe)
Date: Wed, 18 Jul 2018 11:40:37 +0000
Subject: [PATCH v2 1/5] dt-bindings: net: dwmac-sun8i: Remove unused
 address-cells/size-cells
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Message-ID: <1531914041-14751-2-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index cfe724398a12..5bb3a18cc38d 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -19,8 +19,6 @@ Required properties:
 - reset-names: must be "stmmaceth"
 - phy-mode: See ethernet.txt
 - phy-handle: See ethernet.txt
-- #address-cells: shall be 1
-- #size-cells: shall be 0
 - syscon: A phandle to the device containing the EMAC or GMAC clock register
 
 Optional properties:
@@ -86,8 +84,6 @@ emac: ethernet at 1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&int_mii_phy>;
 	phy-mode = "mii";
@@ -137,8 +133,6 @@ emac: ethernet at 1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
@@ -191,8 +185,6 @@ emac: ethernet at 1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
-- 
2.16.4
