From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:22:48 +0200
Subject: [PATCH 6/7] ARM: debug-ll: Add support for r8a7744
In-Reply-To: <cover.1538123953.git.horms+renesas@verge.net.au>
References: <cover.1538123953.git.horms+renesas@verge.net.au>
Message-ID: <abf3bf537d298db18ad929ceb71c0353d6794f42.1538123953.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Enable low-level debugging support for RZ/G1N (R8A7744). RZ/G1N uses
SCIF0 for the debug console.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig.debug | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f6fcb8a79889..7c86875c9bae 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -940,12 +940,13 @@ choice
 
 	config DEBUG_RCAR_GEN2_SCIF0
 		bool "Kernel low-level debugging messages via SCIF0 on R-Car Gen2 and RZ/G1"
-		depends on ARCH_R8A7743 || ARCH_R8A7790 || ARCH_R8A7791 || \
-			ARCH_R8A7792 || ARCH_R8A7793
+		depends on ARCH_R8A7743 || ARCH_R8A7744 || ARCH_R8A7790 || \
+			ARCH_R8A7791 || ARCH_R8A7792 || ARCH_R8A7793
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  via SCIF0 on Renesas RZ/G1M (R8A7743), R-Car H2 (R8A7790),
-		  M2-W (R8A7791), V2H (R8A7792), or M2-N (R8A7793).
+		  via SCIF0 on Renesas RZ/G1M (R8A7743), RZ/G1N (R8A7744),
+		  R-Car H2 (R8A7790), M2-W (R8A7791), V2H (R8A7792), or
+		  M2-N (R8A7793).
 
 	config DEBUG_RCAR_GEN2_SCIF1
 		bool "Kernel low-level debugging messages via SCIF1 on R8A77470"
-- 
2.11.0
