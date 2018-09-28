From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:48 +0200
Subject: [PATCH 2/4] dt-bindings: arm: Document RZ/A2 SoC DT bindings
In-Reply-To: <cover.1538129305.git.horms+renesas@verge.net.au>
References: <cover.1538129305.git.horms+renesas@verge.net.au>
Message-ID: <d0990cd0930c93e06bdf815ce7c350b621e7fd2f.1538129305.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add device tree bindings documentation for Renesas RZ/A2 (r7s9210) SoC.
Also document new option for "renesas,bsid"

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 8acd3cd819b3..c0f0a344dfe0 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -7,6 +7,8 @@ SoCs:
     compatible = "renesas,emev2"
   - RZ/A1H (R7S72100)
     compatible = "renesas,r7s72100"
+  - RZ/A2 (R7S9210)
+    compatible = "renesas,r7s9210"
   - SH-Mobile AG5 (R8A73A00/SH73A0)
     compatible = "renesas,sh73a0"
   - R-Mobile APE6 (R8A73A40)
@@ -145,12 +147,12 @@ Boards:
     compatible = "renesas,wheat", "renesas,r8a7792"
 
 
-Most Renesas ARM SoCs have a Product Register that allows to retrieve SoC
-product and revision information.  If present, a device node for this register
-should be added.
+Most Renesas ARM SoCs have a Product Register or Boundary Scan ID Register that
+allows to retrieve SoC product and revision information.  If present, a device
+node for this register should be added.
 
 Required properties:
-  - compatible: Must be "renesas,prr".
+  - compatible: Must be "renesas,prr" or "renesas,bsid"
   - reg: Base address and length of the register block.
 
 
-- 
2.11.0
