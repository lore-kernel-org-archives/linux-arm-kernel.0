From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 17:19:02 +0100
Subject: [PATCH] ata: fix Marvell SATA driver dependencies
Message-ID: <5138028.BSQbEP7RRB@amdc1032>
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
 drivers/ata/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-26 15:49:59.919101924 +0100
+++ b/drivers/ata/Kconfig	2014-03-26 17:02:08.187028122 +0100
@@ -273,6 +273,8 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
+	depends on PCI || ARCH_KIRKWOOD || ARCH_MVEBU || ARCH_ORION5X || \
+		   COMPILE_TEST
 	select GENERIC_PHY
 	help
 	  This option enables support for the Marvell Serial ATA family.
