From: heiko@sntech.de (Heiko Stuebner)
Date: Tue,  5 Sep 2017 12:57:34 +0200
Subject: [PATCH 2/7] dt-bindings: gpu: mali-utgard: add optional supply
 regulator
In-Reply-To: <20170905105739.8330-1-heiko@sntech.de>
References: <20170905105739.8330-1-heiko@sntech.de>
Message-ID: <20170905105739.8330-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mali GPUs have a separate supplying regulator in a lot of socs,
so describe a mali-supply property. The already described
operating points will likely also need access to this regulator.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 3b7f6f72f032..bcaa640c883f 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -39,6 +39,9 @@ Optional properties:
     Memory region to allocate from, as defined in
     Documentation/devicetree/bindi/reserved-memory/reserved-memory.txt
 
+  - mali-supply : Phandle to regulator for the Mali device. Refer to
+    Documentation/devicetree/bindings/regulator/regulator.txt for details.
+
   - operating-points-v2:
     Operating Points for the GPU, as defined in
     Documentation/devicetree/bindings/opp/opp.txt
-- 
2.14.1
