From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 30 Jan 2018 20:22:43 +0000
Subject: [RFC v3 10/25] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2
 support
In-Reply-To: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1517343778-27902-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit documents the compatibility with R-Car Gen2 and RZ/G
devices by defining the generic compatible string "renesas,rcar-gen2-wdt".
Also, this patch expands the list of SoC-specific compatible strings to
include RZ/G and R-Car Gen2 devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v1->v3:
* made description less generic and added compatible strings for r8a779[0-4]

 .../devicetree/bindings/watchdog/renesas-wdt.txt       | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index bf6d1ca..a983a74 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -1,17 +1,25 @@
 Renesas Watchdog Timer (WDT) Controller
 
 Required properties:
-- compatible : Should be "renesas,<soctype>-wdt", and
-	       "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
+ - compatible : Must be "renesas,<soctype>-wdt", followed by a generic
+		fallback compatible string when compatible with the generic
+		version.
 	       Examples with soctypes are:
+		 - "renesas,r8a7743-wdt" (RZ/G1M)
+		 - "renesas,r8a7745-wdt" (RZ/G1E)
+	         - "renesas,r8a7790-wdt" (R-Car H2)
+	         - "renesas,r8a7791-wdt" (R-Car M2-W)
+	         - "renesas,r8a7792-wdt" (R-Car V2H)
+	         - "renesas,r8a7793-wdt" (R-Car M2-N)
+	         - "renesas,r8a7794-wdt" (R-Car E2)
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
 	         - "renesas,r8a77995-wdt" (R-Car D3)
 	         - "renesas,r7s72100-wdt" (RZ/A1)
+		The generic compatible string must be:
+		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
+		 - "renesas,rcar-gen3-wdt" for R-Car Gen3
 
-  When compatible with the generic version, nodes must list the SoC-specific
-  version corresponding to the platform first, followed by the generic
-  version.
 
 - reg : Should contain WDT registers location and length
 - clocks : the clock feeding the watchdog timer.
-- 
2.7.4
