From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 11 Oct 2018 10:55:07 +0200
Subject: [PATCH 1/2] [RFC] arm64: renesas: Move SoC Kconfig symbols to
 drivers/soc/renesas/
In-Reply-To: <20181011085508.5234-1-geert+renesas@glider.be>
References: <20181011085508.5234-1-geert+renesas@glider.be>
Message-ID: <20181011085508.5234-2-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with other vendors, which have a single Kconfig symbol
in arch/arm64/Kconfig.platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that drivers/clk/ is included before drivers/soc/.  Hence when
COMPILE_TEST=y, questions will be asked about clock drivers before they
can be auto-selected by SoC support.

Question: Should we introduce a family-specific Kconfig symbol for R-Car
	  Gen3 (ARCH_RCAR_GEN1), which could be used for enabling
	  RST_RCAR?
---
 arch/arm64/Kconfig.platforms | 54 ------------------------
 drivers/soc/renesas/Kconfig  | 81 ++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fecdfc70828c2ac3..e7f1659064f82790 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -165,60 +165,6 @@ config ARCH_RENESAS
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-config ARCH_R8A774A1
-	bool "Renesas RZ/G2M SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas RZ/G2M SoC.
-
-config ARCH_R8A774C0
-	bool "Renesas RZ/G2E SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas RZ/G2E SoC.
-
-config ARCH_R8A7795
-	bool "Renesas R-Car H3 SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car H3 SoC.
-
-config ARCH_R8A7796
-	bool "Renesas R-Car M3-W SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car M3-W SoC.
-
-config ARCH_R8A77965
-	bool "Renesas R-Car M3-N SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car M3-N SoC.
-
-config ARCH_R8A77970
-	bool "Renesas R-Car V3M SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car V3M SoC.
-
-config ARCH_R8A77980
-	bool "Renesas R-Car V3H SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car V3H SoC.
-
-config ARCH_R8A77990
-	bool "Renesas R-Car E3 SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car E3 SoC.
-
-config ARCH_R8A77995
-	bool "Renesas R-Car D3 SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car D3 SoC.
-
 config ARCH_ROCKCHIP
 	bool "Rockchip Platforms"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 407f02c80e8b721c..0ab62024fd20be56 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,30 +3,85 @@ config SOC_RENESAS
 	bool "Renesas SoC driver support" if COMPILE_TEST && !ARCH_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
-	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
-			   ARCH_R8A774A1 || ARCH_R8A774C0 || ARCH_R8A7795 || \
-			   ARCH_R8A7796 || ARCH_R8A77965 || ARCH_R8A77970 || \
-			   ARCH_R8A77980 || ARCH_R8A77990 || ARCH_R8A77995
+	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2
 	select SYSC_R8A7743 if ARCH_R8A7743 || ARCH_R8A7744
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
-	select SYSC_R8A774A1 if ARCH_R8A774A1
-	select SYSC_R8A774C0 if ARCH_R8A774C0
 	select SYSC_R8A7779 if ARCH_R8A7779
 	select SYSC_R8A7790 if ARCH_R8A7790
 	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
 	select SYSC_R8A7792 if ARCH_R8A7792
 	select SYSC_R8A7794 if ARCH_R8A7794
-	select SYSC_R8A7795 if ARCH_R8A7795
-	select SYSC_R8A7796 if ARCH_R8A7796
-	select SYSC_R8A77965 if ARCH_R8A77965
-	select SYSC_R8A77970 if ARCH_R8A77970
-	select SYSC_R8A77980 if ARCH_R8A77980
-	select SYSC_R8A77990 if ARCH_R8A77990
-	select SYSC_R8A77995 if ARCH_R8A77995
 
 if SOC_RENESAS
 
+if ARM64
+
+config ARCH_R8A774A1
+	bool "Renesas RZ/G2M SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A774A1
+	help
+	  This enables support for the Renesas RZ/G2M SoC.
+
+config ARCH_R8A774C0
+	bool "Renesas RZ/G2E SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A774C0
+	help
+	  This enables support for the Renesas RZ/G2E SoC.
+
+config ARCH_R8A7795
+	bool "Renesas R-Car H3 SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A7795
+	help
+	  This enables support for the Renesas R-Car H3 SoC.
+
+config ARCH_R8A7796
+	bool "Renesas R-Car M3-W SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A7796
+	help
+	  This enables support for the Renesas R-Car M3-W SoC.
+
+config ARCH_R8A77965
+	bool "Renesas R-Car M3-N SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A77965
+	help
+	  This enables support for the Renesas R-Car M3-N SoC.
+
+config ARCH_R8A77970
+	bool "Renesas R-Car V3M SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A77970
+	help
+	  This enables support for the Renesas R-Car V3M SoC.
+
+config ARCH_R8A77980
+	bool "Renesas R-Car V3H SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A77980
+	help
+	  This enables support for the Renesas R-Car V3H SoC.
+
+config ARCH_R8A77990
+	bool "Renesas R-Car E3 SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A77990
+	help
+	  This enables support for the Renesas R-Car E3 SoC.
+
+config ARCH_R8A77995
+	bool "Renesas R-Car D3 SoC Platform"
+	select RST_RCAR
+	select SYSC_R8A77995
+	help
+	  This enables support for the Renesas R-Car D3 SoC.
+
+endif # ARM64
+
 # SoC
 config SYSC_R8A7743
 	bool "RZ/G1M System Controller support" if COMPILE_TEST
-- 
2.17.1
