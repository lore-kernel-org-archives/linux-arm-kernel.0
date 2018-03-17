From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Mar 2018 17:28:50 +0800
Subject: [PATCH net-next 05/12] dt-bindings: net: dwmac-sun8i: Add binding for
 GMAC on Allwinner R40 SoC
In-Reply-To: <20180317092857.4396-1-wens@csie.org>
References: <20180317092857.4396-1-wens@csie.org>
Message-ID: <20180317092857.4396-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner R40 SoC has the EMAC controller supported by dwmac-sun8i.
It is named "GMAC", while EMAC refers to the 10/100 Mbps Ethernet
controller supported by sun4i-emac. The controller is the same, but
the R40 has the glue layer controls in the clock control unit (CCU),
with a reduced RX delay chain, and no TX delay chain.

This patch adds the R40 specific bits to the dwmac-sun8i binding.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index 74b3ef79e57a..fe4a48a1eb50 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: must be one of the following string:
 		"allwinner,sun8i-a83t-emac"
 		"allwinner,sun8i-h3-emac"
+		"allwinner,sun8i-r40-gmac"
 		"allwinner,sun8i-v3s-emac"
 		"allwinner,sun50i-a64-emac"
 - reg: address and length of the register for the device.
@@ -24,14 +25,17 @@ Required properties:
  compatible string:
   - allwinner,sun8i-a83t-system-controller
   - allwinner,sun8i-h3-system-controller
+  - allwinner,sun8i-r40-ccu
   - allwinner,sun8i-v3s-system-controller
   - allwinner,sun50i-a64-system-controller
 
 Optional properties:
 - allwinner,tx-delay-ps: TX clock delay chain value in ps.
 			 Range is 0-700. Default is 0.
+			 Unavailable for allwinner,sun8i-r40-gmac
 - allwinner,rx-delay-ps: RX clock delay chain value in ps.
 			 Range is 0-3100. Default is 0.
+			 Range is 0-700 for allwinner,sun8i-r40-gmac
 Both delay properties need to be a multiple of 100. They control the
 clock delay for external RGMII PHY. They are do apply to the internal
 PHY or external non-RGMII PHYs.
-- 
2.16.2
