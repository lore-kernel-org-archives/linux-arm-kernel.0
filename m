From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 19 Nov 2010 08:11:31 -0800
Subject: [PATCH] davinci: kconfig: select at24 eeprom for selected boards
Message-ID: <1290183091-25956-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the at24 eeprom driver is selected for certain boards that
need boot data (e.g. MAC address) from EEPROM.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 84066e8..77671b7 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -61,6 +61,8 @@ config MACH_DAVINCI_EVM
 	bool "TI DM644x EVM"
 	default ARCH_DAVINCI_DM644x
 	depends on ARCH_DAVINCI_DM644x
+	select MISC_DEVICES
+	select EEPROM_AT24
 	help
 	  Configure this option to specify the whether the board used
 	  for development is a DM644x EVM
@@ -68,6 +70,8 @@ config MACH_DAVINCI_EVM
 config MACH_SFFSDR
 	bool "Lyrtech SFFSDR"
 	depends on ARCH_DAVINCI_DM644x
+	select MISC_DEVICES
+	select EEPROM_AT24
 	help
 	  Say Y here to select the Lyrtech Small Form Factor
 	  Software Defined Radio (SFFSDR) board.
@@ -99,6 +103,8 @@ config MACH_DAVINCI_DM6467_EVM
 	default ARCH_DAVINCI_DM646x
 	depends on ARCH_DAVINCI_DM646x
 	select MACH_DAVINCI_DM6467TEVM
+	select MISC_DEVICES
+	select EEPROM_AT24
 	help
 	  Configure this option to specify the whether the board used
 	  for development is a DM6467 EVM
@@ -110,6 +116,8 @@ config MACH_DAVINCI_DM365_EVM
 	bool "TI DM365 EVM"
 	default ARCH_DAVINCI_DM365
 	depends on ARCH_DAVINCI_DM365
+	select MISC_DEVICES
+	select EEPROM_AT24
 	help
 	  Configure this option to specify whether the board used
 	  for development is a DM365 EVM
@@ -119,6 +127,8 @@ config MACH_DAVINCI_DA830_EVM
 	default ARCH_DAVINCI_DA830
 	depends on ARCH_DAVINCI_DA830
 	select GPIO_PCF857X
+	select MISC_DEVICES
+	select EEPROM_AT24
 	help
 	  Say Y here to select the TI DA830/OMAP-L137/AM17x Evaluation Module.
 
@@ -190,6 +200,8 @@ config MACH_TNETV107X
 config MACH_MITYOMAPL138
 	bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
 	depends on ARCH_DAVINCI_DA850
+	select MISC_DEVICES
+	select EEPROM_AT24
 	help
 	  Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
 	  System on Module.  Information on this SoM may be found at
-- 
1.7.2.1
