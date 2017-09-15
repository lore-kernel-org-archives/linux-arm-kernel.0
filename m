From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 11:18:06 +0200
Subject: [PATCH v2 2/8] dt-bindings: gpu: mali-utgard: add optional supply
 regulator
In-Reply-To: <20170915091812.13368-1-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
Message-ID: <20170915091812.13368-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mali GPUs have a separate supplying regulator in a lot of socs,
so describe a mali-supply property. The already described
operating points will likely also need access to this regulator.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 24aacafb2594..25ebf4140e69 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -44,6 +44,10 @@ Optional properties:
     Memory region to allocate from, as defined in
     Documentation/devicetree/bindi/reserved-memory/reserved-memory.txt
 
+  - mali-supply:
+    Phandle to regulator for the Mali device, as defined in
+    Documentation/devicetree/bindings/regulator/regulator.txt for details.
+
   - operating-points-v2:
     Operating Points for the GPU, as defined in
     Documentation/devicetree/bindings/opp/opp.txt
-- 
2.14.1
