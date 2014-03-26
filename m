From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 15:19:23 +0100
Subject: [PATCH] ata: fix R-Car SATA driver dependencies
Message-ID: <4494466.bbG3GqUbue@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sata_rcar host driver depend on ARCH_SHMOBILE config option as
Renesas R-Car SATA support is specific to Renesas SoCs and the driver
to work requires suitable device tree node (or platform device) to be
defined.  Additionally allow the driver build if COMPILE_TEST config
option is set.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-25 20:08:10.220311027 +0100
+++ b/drivers/ata/Kconfig	2014-03-26 15:09:04.259143796 +0100
@@ -298,6 +298,7 @@ config SATA_PROMISE
 
 config SATA_RCAR
 	tristate "Renesas R-Car SATA support"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  This option enables support for Renesas R-Car Serial ATA.
 
