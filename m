From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:43:59 +0100
Subject: [PATCH 04/12] dt-bindings: media: renesas-fcp: Remove SoC-specific
 compatible strings
In-Reply-To: <cover.1478251192.git.horms+renesas@verge.net.au>
References: <cover.1478251192.git.horms+renesas@verge.net.au>
Message-ID: <a733c81115da9aa501f3cd918fe5b9f3bbe03b11.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The FCP IP cores include a version register that identifies which SoC
model the IP is integrated in. SoC-specific compatible strings are not
needed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/media/renesas,fcp.txt | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.txt b/Documentation/devicetree/bindings/media/renesas,fcp.txt
index 27f9b8e459ac..3ec91803ba58 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.txt
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.txt
@@ -11,15 +11,9 @@ are paired with. These DT bindings currently support the FCPV and FCPF.
 
  - compatible: Must be one or more of the following
 
-   - "renesas,r8a7795-fcpv" for R8A7795 (R-Car H3) compatible 'FCP for VSP'
-   - "renesas,r8a7795-fcpf" for R8A7795 (R-Car H3) compatible 'FCP for FDP'
    - "renesas,fcpv" for generic compatible 'FCP for VSP'
    - "renesas,fcpf" for generic compatible 'FCP for FDP'
 
-   When compatible with the generic version, nodes must list the
-   SoC-specific version corresponding to the platform first, followed by the
-   family-specific and/or generic versions.
-
  - reg: the register base and size for the device registers
  - clocks: Reference to the functional clock
 
@@ -32,7 +26,7 @@ Device node example
 -------------------
 
 	fcpvd1: fcp at fea2f000 {
-		compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+		compatible = "renesas,fcpv";
 		reg = <0 0xfea2f000 0 0x200>;
 		clocks = <&cpg CPG_MOD 602>;
 		power-domains = <&sysc R8A7795_PD_A3VP>;
-- 
2.7.0.rc3.207.g0ac5344
