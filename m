From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Jun 2017 22:07:34 +0800
Subject: [PATCH 1/4] dt-bindings: net-next: Add DT bindings documentation for
 Allwinner V3s EMAC
In-Reply-To: <20170617140737.41951-1-icenowy@aosc.io>
References: <20170617140737.41951-1-icenowy@aosc.io>
Message-ID: <20170617140737.41951-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC has a Ethernet MAC like the one in Allwinner H3, but
have no external MII capability. That means that it can only use the
EPHY and cannot do Gbps transmission.

Add binding for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index 08e708c73193..725f3b187886 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: should be one of the following string:
 		"allwinner,sun8i-a83t-emac"
 		"allwinner,sun8i-h3-emac"
+		"allwinner,sun8i-v3s-emac"
 		"allwinner,sun50i-a64-emac"
 - reg: address and length of the register for the device.
 - interrupts: interrupt for the device
@@ -22,6 +23,7 @@ Required properties:
 - syscon: A phandle to the syscon of the SoC with one of the following
  compatible string:
   - allwinner,sun8i-h3-system-controller
+  - allwinner,sun8i-v3s-system-controller
   - allwinner,sun50i-a64-system-controller
   - allwinner,sun8i-a83t-system-controller
 
@@ -31,7 +33,9 @@ Optional properties:
 Both delay properties need to be a multiple of 100. They control the delay for
 external PHY.
 
-Optional properties for "allwinner,sun8i-h3-emac":
+Optional properties for the following compatibles:
+  - "allwinner,sun8i-h3-emac",
+  - "allwinner,sun8i-v3s-emac":
 - allwinner,leds-active-low: EPHY LEDs are active low
 
 Required child node of emac:
@@ -44,7 +48,9 @@ Required properties of the mdio node:
 The device node referenced by "phy" or "phy-handle" should be a child node
 of the mdio node. See phy.txt for the generic PHY bindings.
 
-Required properties of the phy node with "allwinner,sun8i-h3-emac":
+Required properties of the phy node with the following compatibles:
+  - "allwinner,sun8i-h3-emac",
+  - "allwinner,sun8i-v3s-emac":
 - clocks: a phandle to the reference clock for the EPHY
 - resets: a phandle to the reset control for the EPHY
 
-- 
2.13.0
