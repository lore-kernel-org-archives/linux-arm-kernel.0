From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 11:18:05 +0200
Subject: [PATCH v2 1/8] dt-bindings: gpu: mali-utgard: Add Rockchip Utgard
 Malis
In-Reply-To: <20170915091812.13368-1-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
Message-ID: <20170915091812.13368-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some (older or lower power) Rockchip socs use Utgard-based Mali-GPUs.
So add the necessary compatibles for them. As the setup is the same for
all of them (needing only the additional reset line), they get added in
a somewhat condensed form, to not inflate the document unnecessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index b4ebd56d03f3..24aacafb2594 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -13,6 +13,10 @@ Required properties:
       + allwinner,sun50i-h5-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
+      + rockchip,rk3036-mali
+      + rockchip,rk3066-mali
+      + rockchip,rk3188-mali
+      + rockchip,rk3228-mali
       + stericsson,db8500-mali
 
   - reg: Physical base address and length of the GPU registers
@@ -63,6 +67,10 @@ to specify one more vendor-specific compatible, among:
     Required properties:
       * resets: phandle to the reset line for the GPU
 
+  - Rockchip variants:
+    Required properties:
+      * resets: phandle to the reset line for the GPU
+
   - stericsson,db8500-mali
     Required properties:
       * interrupt-names and interrupts:
-- 
2.14.1
