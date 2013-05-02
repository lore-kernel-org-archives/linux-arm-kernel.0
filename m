From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu,  2 May 2013 20:25:37 +0200
Subject: [PATCH 0/3] ARM: dove: prepare and move to orion irqchip driver
Message-ID: <1367519140-19716-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set moves Dove to the recently introduced irqchip driver
for Marvell Orion SoCs. First, init code for timer and mv643xx_eth
is added to prepare legacy non-DT drivers for virtual irqs provided by
irqchip drivers. Then DT enabled boards for Dove are moved to the
orion irqchip driver.

Note: This patch set depends on irqchip driver for Orion SoCs patch.

Sebastian Hesselbarth (3):
  ARM: dove: add DT parsing for legacy mv643xx_eth
  ARM: dove: add DT parsing for legacy timer
  ARM: dove: move DT boards to orion irqchip driver

 arch/arm/boot/dts/dove.dtsi   |   18 ++++++++-
 arch/arm/mach-dove/Kconfig    |    1 +
 arch/arm/mach-dove/Makefile   |    4 +-
 arch/arm/mach-dove/board-dt.c |   77 ++++++++++++++++++++++++++++++++++++-----
 4 files changed, 87 insertions(+), 13 deletions(-)
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.2.5
