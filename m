From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Sep 2017 09:54:42 +0200
Subject: [PATCH 1/3] ARM: debug-ll: Add support for r8a7745
In-Reply-To: <cover.1506325834.git.horms+renesas@verge.net.au>
References: <cover.1506325834.git.horms+renesas@verge.net.au>
Message-ID: <8e5f2d651f5b8ebf4b462aac02f51fe6075f88c0.1506325834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Enable low-level debugging support for RZ/G1E (r8a7745). RZ/G1E uses
SCIF4 for the debug console.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6dcea8e8e941..31bf312be7d5 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -911,6 +911,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF2 on Renesas R-Car E2 (R8A7794).
 
+	config DEBUG_RCAR_GEN2_SCIF4
+		bool "Kernel low-level debugging messages via SCIF4 on R8A7745"
+		depends on ARCH_R8A7745
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF4 on Renesas RZ/G1E (R8A7745).
+
 	config DEBUG_RMOBILE_SCIFA0
 		bool "Kernel low-level debugging messages via SCIFA0 on R8A73A4"
 		depends on ARCH_R8A73A4
@@ -1451,6 +1458,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF0
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF2
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF4
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA0
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA1
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
@@ -1570,6 +1578,7 @@ config DEBUG_UART_PHYS
 	default 0xe6c80000 if DEBUG_RMOBILE_SCIFA4
 	default 0xe6e58000 if DEBUG_RCAR_GEN2_SCIF2
 	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
+	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
@@ -1604,6 +1613,7 @@ config DEBUG_UART_PHYS
 		DEBUG_QCOM_UARTDM || DEBUG_R7S72100_SCIF2 || \
 		DEBUG_RCAR_GEN1_SCIF0 || DEBUG_RCAR_GEN1_SCIF2 || \
 		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF2 || \
+		DEBUG_RCAR_GEN2_SCIF4 || \
 		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
 		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
 		DEBUG_S3C64XX_UART || \
-- 
2.1.4
