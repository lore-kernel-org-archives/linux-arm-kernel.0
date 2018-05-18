From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:47 +0200
Subject: [PATCH 5/6] dt-bindings: timer: renesas,
 cmt: Document r8a774[35] CMT support
In-Reply-To: <cover.1526549153.git.horms+renesas@verge.net.au>
References: <cover.1526549153.git.horms+renesas@verge.net.au>
Message-ID: <24d79d738b6fed977f44cae2ca277a49a7aa5f70.1526549153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document SoC specific compatible strings for r8a7743 and r8a7745.
No driver change is needed as the fallback strings will activate
the right code.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index d740989eb569..b40add2d9bb4 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -22,6 +22,10 @@ Required Properties:
 
     - "renesas,r8a73a4-cmt0" for the 32-bit CMT0 device included in r8a73a4.
     - "renesas,r8a73a4-cmt1" for the 48-bit CMT1 device included in r8a73a4.
+    - "renesas,r8a7743-cmt0" for the 32-bit CMT0 device included in r8a7743.
+    - "renesas,r8a7743-cmt1" for the 48-bit CMT1 device included in r8a7743.
+    - "renesas,r8a7745-cmt0" for the 32-bit CMT0 device included in r8a7745.
+    - "renesas,r8a7745-cmt1" for the 48-bit CMT1 device included in r8a7745.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
@@ -31,10 +35,12 @@ Required Properties:
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
 
-    - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2.
-    - "renesas,rcar-gen2-cmt1" for 48-bit CMT1 devices included in R-Car Gen2.
-		These are fallbacks for r8a73a4 and all the R-Car Gen2
-		entries	listed above.
+    - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2
+		and RZ/G1.
+    - "renesas,rcar-gen2-cmt1" for 48-bit CMT1 devices included in R-Car Gen2
+		and RZ/G1.
+		These are fallbacks for r8a73a4, R-Car Gen2 and RZ/G1 entries
+		listed above.
 
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
-- 
2.11.0
