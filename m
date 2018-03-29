From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 29 Mar 2018 11:42:26 +0100
Subject: [PATCH] ARM: debug-ll: Add support for r8a77470
Message-ID: <1522320146-41110-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable low-level debugging support for RZ/G1C (r8a77470). RZ/G1C uses
SCIF1 for the debug console.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
* This patch has runtime depency on
https://www.spinics.net/lists/arm-kernel/msg644192.html

 arch/arm/Kconfig.debug | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 78a6470..5778103 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -941,6 +941,13 @@ choice
 		  via SCIF0 on Renesas RZ/G1M (R8A7743), R-Car H2 (R8A7790),
 		  M2-W (R8A7791), V2H (R8A7792), or M2-N (R8A7793).
 
+	config DEBUG_RCAR_GEN2_SCIF1
+		bool "Kernel low-level debugging messages via SCIF1 on R8A77470"
+		depends on ARCH_R8A77470
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF1 on Renesas RZ/G1C (R8A77470).
+
 	config DEBUG_RCAR_GEN2_SCIF2
 		bool "Kernel low-level debugging messages via SCIF2 on R8A7794"
 		depends on ARCH_R8A7794
@@ -1494,6 +1501,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF0
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF0
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF1
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF4
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA0
@@ -1616,6 +1624,7 @@ config DEBUG_UART_PHYS
 	default 0xe6c80000 if DEBUG_RMOBILE_SCIFA4
 	default 0xe6e58000 if DEBUG_RCAR_GEN2_SCIF2
 	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
+	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
 	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
@@ -1650,8 +1659,8 @@ config DEBUG_UART_PHYS
 		DEBUG_NETX_UART || \
 		DEBUG_QCOM_UARTDM || DEBUG_R7S72100_SCIF2 || \
 		DEBUG_RCAR_GEN1_SCIF0 || DEBUG_RCAR_GEN1_SCIF2 || \
-		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF2 || \
-		DEBUG_RCAR_GEN2_SCIF4 || \
+		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF1 || \
+		DEBUG_RCAR_GEN2_SCIF2 || DEBUG_RCAR_GEN2_SCIF4 || \
 		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
 		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
 		DEBUG_S3C64XX_UART || \
-- 
2.7.4
