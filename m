From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:05:36 +0200
Subject: [PATCH 1/5] ARM: debug-ll: Add support for r8a7743
In-Reply-To: <cover.1501512320.git.horms+renesas@verge.net.au>
References: <cover.1501512320.git.horms+renesas@verge.net.au>
Message-ID: <fcfbb6f144065f301f60555e5475434f2956eeb8.1501512320.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Paterson <chris.paterson2@renesas.com>

Enable low-level debugging support for RZ/G1M (r8a7743). RZ/G1M uses
SCIF0 for the debug console, like most of the R-Car Gen2 SoCs.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig.debug | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 447629d89884..003502eb5642 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -896,12 +896,13 @@ choice
 		  via SCIF2 on Renesas R-Car H1 (R8A7779).
 
 	config DEBUG_RCAR_GEN2_SCIF0
-		bool "Kernel low-level debugging messages via SCIF0 on R8A7790/R8A7791/R8A7792/R8A7793"
-		depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7792 || ARCH_R8A7793
+		bool "Kernel low-level debugging messages via SCIF0 on R-Car Gen2 and RZ/G1"
+		depends on ARCH_R8A7743 || ARCH_R8A7790 || ARCH_R8A7791 || \
+			ARCH_R8A7792 || ARCH_R8A7793
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  via SCIF0 on Renesas R-Car H2 (R8A7790), M2-W (R8A7791), V2H
-		  (R8A7792), or M2-N (R8A7793).
+		  via SCIF0 on Renesas RZ/G1M (R8A7743), R-Car H2 (R8A7790),
+		  M2-W (R8A7791), V2H (R8A7792), or M2-N (R8A7793).
 
 	config DEBUG_RCAR_GEN2_SCIF2
 		bool "Kernel low-level debugging messages via SCIF2 on R8A7794"
-- 
2.1.4
