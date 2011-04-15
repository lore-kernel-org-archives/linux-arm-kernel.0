From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 13:32:40 +0100
Subject: [PATCH] ARM: Davinci: Fix I2C build errors
Message-ID: <20110415123240.GK1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several Davinci platforms select the I2C EEPROM support, but don't
select I2C support.  This causes I2C EEPROM support to be built into
the kernel, but I2C support may not be configured to be built in.
This leads to linker errors due to missing I2C symbols.

Arrange for I2C to be selected whenever EEPROM_AT24 is selected.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-davinci/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 32f1479..c0deaca 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -63,6 +63,7 @@ config MACH_DAVINCI_EVM
 	depends on ARCH_DAVINCI_DM644x
 	select MISC_DEVICES
 	select EEPROM_AT24
+	select I2C
 	help
 	  Configure this option to specify the whether the board used
 	  for development is a DM644x EVM
@@ -72,6 +73,7 @@ config MACH_SFFSDR
 	depends on ARCH_DAVINCI_DM644x
 	select MISC_DEVICES
 	select EEPROM_AT24
+	select I2C
 	help
 	  Say Y here to select the Lyrtech Small Form Factor
 	  Software Defined Radio (SFFSDR) board.
@@ -105,6 +107,7 @@ config MACH_DAVINCI_DM6467_EVM
 	select MACH_DAVINCI_DM6467TEVM
 	select MISC_DEVICES
 	select EEPROM_AT24
+	select I2C
 	help
 	  Configure this option to specify the whether the board used
 	  for development is a DM6467 EVM
@@ -118,6 +121,7 @@ config MACH_DAVINCI_DM365_EVM
 	depends on ARCH_DAVINCI_DM365
 	select MISC_DEVICES
 	select EEPROM_AT24
+	select I2C
 	help
 	  Configure this option to specify whether the board used
 	  for development is a DM365 EVM
@@ -129,6 +133,7 @@ config MACH_DAVINCI_DA830_EVM
 	select GPIO_PCF857X
 	select MISC_DEVICES
 	select EEPROM_AT24
+	select I2C
 	help
 	  Say Y here to select the TI DA830/OMAP-L137/AM17x Evaluation Module.
 
@@ -205,6 +210,7 @@ config MACH_MITYOMAPL138
 	depends on ARCH_DAVINCI_DA850
 	select MISC_DEVICES
 	select EEPROM_AT24
+	select I2C
 	help
 	  Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
 	  System on Module.  Information on this SoM may be found at
