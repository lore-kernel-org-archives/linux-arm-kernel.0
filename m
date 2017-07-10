From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Jul 2017 14:12:26 +0200
Subject: [PATCH 1/2] dt-bindings: gpu: drop wrong compatible from midgard
 binding example
Message-ID: <20170710121227.14264-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding rightfully only specifies compatibles for actual implementations
and not for the whole family. In the example an arm,mali-midgard slipped
through from downstream devicetrees though. So drop that to not confuse
people reading (or copying) that example.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index d3b6e1a4713a..5aa5926029ee 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -40,7 +40,7 @@ Optional properties:
 Example for a Mali-T760:
 
 gpu at ffa30000 {
-	compatible = "rockchip,rk3288-mali", "arm,mali-t760", "arm,mali-midgard";
+	compatible = "rockchip,rk3288-mali", "arm,mali-t760";
 	reg = <0xffa30000 0x10000>;
 	interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.11.0
