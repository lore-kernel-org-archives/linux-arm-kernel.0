From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 16:39:50 +0100
Subject: [PATCH] ata: fix Calxeda Highbank SATA driver dependencies
Message-ID: <2920312.TnoQcCR5HX@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sata_highbank host driver depend on ARCH_HIGHBANK config option
as Calxeda Highbank SATA support is specific to Calxeda Highbank
SoCs and the driver to work requires suitable device tree node to
be defined.  Additionally allow the driver build if COMPILE_TEST
config option is set.

Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-26 15:32:57.455119357 +0100
+++ b/drivers/ata/Kconfig	2014-03-26 15:49:59.919101924 +0100
@@ -264,6 +264,7 @@ config SATA_DWC_VDEBUG
 
 config SATA_HIGHBANK
 	tristate "Calxeda Highbank SATA support"
+	depends on ARCH_HIGHBANK || COMPILE_TEST
 	help
 	  This option enables support for the Calxeda Highbank SoC's
 	  onboard SATA.
