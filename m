From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 17:59:03 +0100
Subject: [PATCH v2] ata: fix Marvell SATA driver dependencies
Message-ID: <3641258.OaO7lhnDYy@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
ARCH_ORION5X config options as Marvell SATA support covers both Marvell
PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs (for
non-PCI devices the driver to work requires suitable device tree node to
be defined).  Additionally allow the driver build if COMPILE_TEST config
option is set.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- previous patch was against libata/for-next branch
  (SATA_MV selects GENERIC_PHY in for-next branch)

 drivers/ata/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-26 17:43:46.000000000 +0100
+++ b/drivers/ata/Kconfig	2014-03-26 17:45:34.522983681 +0100
@@ -281,6 +281,8 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
+	depends on PCI || ARCH_KIRKWOOD || ARCH_MVEBU || ARCH_ORION5X || \
+		   COMPILE_TEST
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,
