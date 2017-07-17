From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 17 Jul 2017 09:33:52 +0100
Subject: [PATCH net-next repost v2] dt-bindings: net: ravb : Add support for
 r8a7743 SoC
Message-ID: <1500280432-43162-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible string for the RZ/G1M (R8A7743) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v1->v2
* Changed the subject
* re-formatted the required properties

 .../devicetree/bindings/net/renesas,ravb.txt       | 29 +++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index b519503..4717bc2 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -4,19 +4,24 @@ This file provides information on what the device node for the Ethernet AVB
 interface contains.
 
 Required properties:
-- compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
-	      "renesas,etheravb-r8a7791" if the device is a part of R8A7791 SoC.
-	      "renesas,etheravb-r8a7792" if the device is a part of R8A7792 SoC.
-	      "renesas,etheravb-r8a7793" if the device is a part of R8A7793 SoC.
-	      "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
-	      "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
-	      "renesas,etheravb-r8a7796" if the device is a part of R8A7796 SoC.
-	      "renesas,etheravb-rcar-gen2" for generic R-Car Gen 2 compatible interface.
-	      "renesas,etheravb-rcar-gen3" for generic R-Car Gen 3 compatible interface.
+- compatible: Must contain one or more of the following:
+      - "renesas,etheravb-r8a7743" for the R8A7743 SoC.
+      - "renesas,etheravb-r8a7790" for the R8A7790 SoC.
+      - "renesas,etheravb-r8a7791" for the R8A7791 SoC.
+      - "renesas,etheravb-r8a7792" for the R8A7792 SoC.
+      - "renesas,etheravb-r8a7793" for the R8A7793 SoC.
+      - "renesas,etheravb-r8a7794" for the R8A7794 SoC.
+      - "renesas,etheravb-rcar-gen2" as a fallback for the above
+		R-Car Gen2 and RZ/G1 devices.
 
-	      When compatible with the generic version, nodes must list the
-	      SoC-specific version corresponding to the platform first
-	      followed by the generic version.
+      - "renesas,etheravb-r8a7795" for the R8A7795 SoC.
+      - "renesas,etheravb-r8a7796" for the R8A7796 SoC.
+      - "renesas,etheravb-rcar-gen3" as a fallback for the above
+		R-Car Gen3 devices.
+
+	When compatible with the generic version, nodes must list the
+	SoC-specific version corresponding to the platform first followed by
+	the generic version.
 
 - reg: offset and length of (1) the register block and (2) the stream buffer.
 - interrupts: A list of interrupt-specifiers, one for each entry in
-- 
1.9.1
