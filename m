From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 16 Nov 2018 14:48:42 +0100
Subject: [PATCH v2 2/2] ARM: shmobile: Move SoC Kconfig symbols to
 drivers/soc/renesas/
In-Reply-To: <20181116134842.26488-1-geert+renesas@glider.be>
References: <20181116134842.26488-1-geert+renesas@glider.be>
Message-ID: <20181116134842.26488-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with arm64, where vendors have a single Kconfig symbol
in arch/arm64/Kconfig.platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Move family-specific Kconfig symbols, too.
---
 arch/arm/mach-shmobile/Kconfig | 126 ----------------------------
 drivers/soc/renesas/Kconfig    | 148 +++++++++++++++++++++++++++++++--
 2 files changed, 139 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 70c6f557f8cd1694..9b798c9dffe4e94a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,31 +4,6 @@ config PM_RMOBILE
 	select PM
 	select PM_GENERIC_DOMAINS
 
-config ARCH_RCAR_GEN1
-	bool
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_TMU
-
-config ARCH_RCAR_GEN2
-	bool
-	select HAVE_ARM_ARCH_TIMER
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
-
-config ARCH_RMOBILE
-	bool
-	select PM_RMOBILE
-	select SYS_SUPPORTS_SH_CMT
-	select SYS_SUPPORTS_SH_TMU
-
-config ARCH_RZN1
-	bool
-	select ARM_AMBA
-
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
@@ -38,104 +13,3 @@ menuconfig ARCH_RENESAS
 	select PINCTRL
 	select SOC_BUS
 	select ZONE_DMA if ARM_LPAE
-
-if ARCH_RENESAS
-
-#comment "Renesas ARM SoCs System Type"
-
-config ARCH_EMEV2
-	bool "Emma Mobile EV2"
-	select HAVE_ARM_SCU if SMP
-	select SYS_SUPPORTS_EM_STI
-
-config ARCH_R7S72100
-	bool "RZ/A1H (R7S72100)"
-	select PM
-	select PM_GENERIC_DOMAINS
-	select SYS_SUPPORTS_SH_MTU2
-	select RENESAS_OSTM
-
-config ARCH_R7S9210
-	bool "RZ/A2 (R7S9210)"
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_OSTM
-
-config ARCH_R8A73A4
-	bool "R-Mobile APE6 (R8A73A40)"
-	select ARCH_RMOBILE
-	select ARM_ERRATA_798181 if SMP
-	select HAVE_ARM_ARCH_TIMER
-	select RENESAS_IRQC
-
-config ARCH_R8A7740
-	bool "R-Mobile A1 (R8A77400)"
-	select ARCH_RMOBILE
-	select RENESAS_INTC_IRQPIN
-
-config ARCH_R8A7743
-	bool "RZ/G1M (R8A77430)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7744
-	bool "RZ/G1N (R8A77440)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7745
-	bool "RZ/G1E (R8A77450)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R8A77470
-	bool "RZ/G1C (R8A77470)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R8A7778
-	bool "R-Car M1A (R8A77781)"
-	select ARCH_RCAR_GEN1
-
-config ARCH_R8A7779
-	bool "R-Car H1 (R8A77790)"
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select ARCH_RCAR_GEN1
-
-config ARCH_R8A7790
-	bool "R-Car H2 (R8A77900)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7791
-	bool "R-Car M2-W (R8A77910)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7792
-	bool "R-Car V2H (R8A77920)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7793
-	bool "R-Car M2-N (R8A7793)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7794
-	bool "R-Car E2 (R8A77940)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R9A06G032
-	bool "RZ/N1D (R9A06G032)"
-	select ARCH_RZN1
-
-config ARCH_SH73A0
-	bool "SH-Mobile AG5 (R8A73A00)"
-	select ARCH_RMOBILE
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select RENESAS_INTC_IRQPIN
-endif
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 2f5bc5a6ae2b67e3..fe7f58616cdd6cf7 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,18 +3,26 @@ config SOC_RENESAS
 	bool "Renesas SoC driver support" if COMPILE_TEST && !ARCH_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
-	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2
-	select SYSC_R8A7743 if ARCH_R8A7743 || ARCH_R8A7744
-	select SYSC_R8A7745 if ARCH_R8A7745
-	select SYSC_R8A77470 if ARCH_R8A77470
-	select SYSC_R8A7779 if ARCH_R8A7779
-	select SYSC_R8A7790 if ARCH_R8A7790
-	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
-	select SYSC_R8A7792 if ARCH_R8A7792
-	select SYSC_R8A7794 if ARCH_R8A7794
 
 if SOC_RENESAS
 
+config ARCH_RCAR_GEN1
+	bool
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_INTC_IRQPIN
+	select RST_RCAR
+	select SYS_SUPPORTS_SH_TMU
+
+config ARCH_RCAR_GEN2
+	bool
+	select HAVE_ARM_ARCH_TIMER
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_IRQC
+	select RST_RCAR
+	select SYS_SUPPORTS_SH_CMT
+
 config ARCH_RCAR_GEN3
 	bool
 	select PM
@@ -24,6 +32,128 @@ config ARCH_RCAR_GEN3
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
+config ARCH_RMOBILE
+	bool
+	select PM_RMOBILE
+	select SYS_SUPPORTS_SH_CMT
+	select SYS_SUPPORTS_SH_TMU
+
+config ARCH_RZN1
+	bool
+	select ARM_AMBA
+
+if ARM
+
+#comment "Renesas ARM SoCs System Type"
+
+config ARCH_EMEV2
+	bool "Emma Mobile EV2"
+	select HAVE_ARM_SCU if SMP
+	select SYS_SUPPORTS_EM_STI
+
+config ARCH_R7S72100
+	bool "RZ/A1H (R7S72100)"
+	select PM
+	select PM_GENERIC_DOMAINS
+	select SYS_SUPPORTS_SH_MTU2
+	select RENESAS_OSTM
+
+config ARCH_R7S9210
+	bool "RZ/A2 (R7S9210)"
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_OSTM
+
+config ARCH_R8A73A4
+	bool "R-Mobile APE6 (R8A73A40)"
+	select ARCH_RMOBILE
+	select ARM_ERRATA_798181 if SMP
+	select HAVE_ARM_ARCH_TIMER
+	select RENESAS_IRQC
+
+config ARCH_R8A7740
+	bool "R-Mobile A1 (R8A77400)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
+config ARCH_R8A7743
+	bool "RZ/G1M (R8A77430)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7743
+
+config ARCH_R8A7744
+	bool "RZ/G1N (R8A77440)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7743
+
+config ARCH_R8A7745
+	bool "RZ/G1E (R8A77450)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A7745
+
+config ARCH_R8A77470
+	bool "RZ/G1C (R8A77470)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A77470
+
+config ARCH_R8A7778
+	bool "R-Car M1A (R8A77781)"
+	select ARCH_RCAR_GEN1
+
+config ARCH_R8A7779
+	bool "R-Car H1 (R8A77790)"
+	select ARCH_RCAR_GEN1
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select SYSC_R8A7779
+
+config ARCH_R8A7790
+	bool "R-Car H2 (R8A77900)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7790
+
+config ARCH_R8A7791
+	bool "R-Car M2-W (R8A77910)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7791
+
+config ARCH_R8A7792
+	bool "R-Car V2H (R8A77920)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7792
+
+config ARCH_R8A7793
+	bool "R-Car M2-N (R8A7793)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7791
+
+config ARCH_R8A7794
+	bool "R-Car E2 (R8A77940)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A7794
+
+config ARCH_R9A06G032
+	bool "RZ/N1D (R9A06G032)"
+	select ARCH_RZN1
+
+config ARCH_SH73A0
+	bool "SH-Mobile AG5 (R8A73A00)"
+	select ARCH_RMOBILE
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select RENESAS_INTC_IRQPIN
+
+endif # ARM
+
 if ARM64
 
 config ARCH_R8A774A1
-- 
2.17.1
