From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 14 Oct 2017 20:29:24 +0800
Subject: [PATCH 1/2] dt-bindings: add binding for A64 DE2 CCU with SRAM section
Message-ID: <20171014122925.13220-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A64's Display Engine 2.0 needs a section of SRAM (SRAM C) to be claimed.

Add binding for this.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
index 631d27cd89d6..8b1f86080d3d 100644
--- a/Documentation/devicetree/bindings/clock/sun8i-de2.txt
+++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
@@ -5,6 +5,7 @@ Required properties :
 - compatible: must contain one of the following compatibles:
 		- "allwinner,sun8i-a83t-de2-clk"
 		- "allwinner,sun8i-v3s-de2-clk"
+		- "allwinner,sun50i-a64-de2-clk"
 		- "allwinner,sun50i-h5-de2-clk"
 
 - reg: Must contain the registers base address and length
@@ -17,6 +18,10 @@ Required properties :
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
 
+Additional required properties for "allwinner,sun50i-a64-de2-clk" :
+- allwinner,sram: See Documentation/devicetree/bindings/sram/sunxi-sram.txt,
+		  should be the SRAM C section on A64 SoC.
+
 Example:
 de2_clocks: clock at 1000000 {
 	compatible = "allwinner,sun8i-a83t-de2-clk";
-- 
2.13.6
