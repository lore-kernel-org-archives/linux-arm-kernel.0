From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu,  8 Jun 2017 08:48:37 +0100
Subject: [PATCH] ARM: debug-ll: Add support for r8a7743
Message-ID: <1496908117-19368-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable low-level debugging support for RZ/G1M (r8a7743). RZ/G1M uses
SCIF0 for the debug console, like most of the R-Car Gen2 SoCs.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/Kconfig.debug | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ba2cb63..fd5164c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -895,12 +895,13 @@ choice
 		  via SCIF2 on Renesas R-Car H1 (R8A7779).
 
 	config DEBUG_RCAR_GEN2_SCIF0
-		bool "Kernel low-level debugging messages via SCIF0 on R8A7790/R8A7791/R8A7792/R8A7793"
-		depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7792 || ARCH_R8A7793
+		bool "Kernel low-level debugging messages via SCIF0 on R8A7743/R8A7790/R8A7791/R8A7792/R8A7793"
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
1.9.1
