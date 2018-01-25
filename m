From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 25 Jan 2018 18:02:55 +0000
Subject: [RFC 21/37] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1516903391-30467-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit documents the compatibility with R-Car Gen2 and RZ/G
devices by defining the generifc compatible string "renesas,rcar-gen2-wdt".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index bf6d1ca..436dca5 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -1,17 +1,20 @@
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
