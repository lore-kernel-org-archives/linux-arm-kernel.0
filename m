From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:30 -0700
Subject: [PATCH 06/47] davinci: introduce support for AM1x ARM9 microprocessors
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-7-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

The Sitara AM17x SoCs from TI are an OMAP-L137 pin-to-pin
compatible ARM9 microprocessor offering from TI.

The Sitara AM18x SoCs from TI are an OMAP-L138 pin-to-pin
compatible ARM9 microprocessor offering from TI.

More information about these processors available at:
www.ti.com/am1x

Because of their compatibiliy with OMAP-L1x, the kernel
support for OMAP-L1x is fully relevant to AM1x processors.

This patch updates the Kconfig prompt and help text to include
the AM1x part names to help users select configurations required
for these parts easily.

Also, the hardware information that shows up in /proc/cpuinfo
is updated to show applicability of the respective OMAP-L1x EVMs
for AM1x parts.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig           |   30 +++++++++++++++---------------
 arch/arm/mach-davinci/board-da830-evm.c |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c |    2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index b291da1..2bf03e9 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -30,13 +30,13 @@ config ARCH_DAVINCI_DM646x
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DA830
-	bool "DA830/OMAP-L137 based system"
+	bool "DA830/OMAP-L137/AM17x based system"
 	select CP_INTC
 	select ARCH_DAVINCI_DA8XX
 	select CPU_DCACHE_WRITETHROUGH # needed on silicon revs 1.0, 1.1
 
 config ARCH_DAVINCI_DA850
-	bool "DA850/OMAP-L138 based system"
+	bool "DA850/OMAP-L138/AM18x based system"
 	select CP_INTC
 	select ARCH_DAVINCI_DA8XX
 	select ARCH_HAS_CPUFREQ
@@ -115,21 +115,21 @@ config MACH_DAVINCI_DM365_EVM
 	  for development is a DM365 EVM
 
 config MACH_DAVINCI_DA830_EVM
-	bool "TI DA830/OMAP-L137 Reference Platform"
+	bool "TI DA830/OMAP-L137/AM17x Reference Platform"
 	default ARCH_DAVINCI_DA830
 	depends on ARCH_DAVINCI_DA830
 	select GPIO_PCF857X
 	help
-	  Say Y here to select the TI DA830/OMAP-L137 Evaluation Module.
+	  Say Y here to select the TI DA830/OMAP-L137/AM17x Evaluation Module.
 
 choice
-	prompt "Select DA830/OMAP-L137 UI board peripheral"
+	prompt "Select DA830/OMAP-L137/AM17x UI board peripheral"
 	depends on MACH_DAVINCI_DA830_EVM
 	help
-	  The presence of UI card on the DA830/OMAP-L137 EVM is detected
-	  automatically based on successful probe of the I2C based GPIO
-	  expander on that board. This option selected in this menu has
-	  an effect only in case of a successful UI card detection.
+	  The presence of UI card on the DA830/OMAP-L137/AM17x EVM is
+	  detected automatically based on successful probe of the I2C
+	  based GPIO expander on that board. This option selected in this
+	  menu has an effect only in case of a successful UI card detection.
 
 config DA830_UI_LCD
 	bool "LCD"
@@ -145,18 +145,18 @@ config DA830_UI_NAND
 endchoice
 
 config MACH_DAVINCI_DA850_EVM
-	bool "TI DA850/OMAP-L138 Reference Platform"
+	bool "TI DA850/OMAP-L138/AM18x Reference Platform"
 	default ARCH_DAVINCI_DA850
 	depends on ARCH_DAVINCI_DA850
 	select GPIO_PCA953X
 	help
-	  Say Y here to select the TI DA850/OMAP-L138 Evaluation Module.
+	  Say Y here to select the TI DA850/OMAP-L138/AM18x Evaluation Module.
 
 choice
 	prompt "Select peripherals connected to expander on UI board"
 	depends on MACH_DAVINCI_DA850_EVM
 	help
-	  The presence of User Interface (UI) card on the DA850/OMAP-L138
+	  The presence of User Interface (UI) card on the DA850/OMAP-L138/AM18x
 	  EVM is detected automatically based on successful probe of the I2C
 	  based GPIO expander on that card. This option selected in this
 	  menu has an effect only in case of a successful UI card detection.
@@ -165,13 +165,13 @@ config DA850_UI_NONE
 	bool "No peripheral is enabled"
 	help
 	  Say Y if you do not want to enable any of the peripherals connected
-	  to TCA6416 expander on DA850/OMAP-L138 EVM UI card
+	  to TCA6416 expander on DA850/OMAP-L138/AM18x EVM UI card
 
 config DA850_UI_RMII
 	bool "RMII Ethernet PHY"
 	help
-	  Say Y if you want to use the RMII PHY on the DA850/OMAP-L138 EVM.
-	  This PHY is found on the UI daughter card that is supplied with
+	  Say Y if you want to use the RMII PHY on the DA850/OMAP-L138/AM18x
+	  EVM. This PHY is found on the UI daughter card that is supplied with
 	  the EVM.
 	  NOTE: Please take care while choosing this option, MII PHY will
 	  not be functional if RMII mode is selected.
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index c3994f3..292e8b7 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -596,7 +596,7 @@ static void __init da830_evm_map_io(void)
 	da830_init();
 }
 
-MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137 EVM")
+MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.phys_io	= IO_PHYS,
 	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 711a56a..f5f9472 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -816,7 +816,7 @@ static void __init da850_evm_map_io(void)
 	da850_init();
 }
 
-MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138 EVM")
+MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.phys_io	= IO_PHYS,
 	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
-- 
1.7.2.1
