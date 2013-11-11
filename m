From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Mon, 11 Nov 2013 14:02:56 +0530
Subject: [PATCH V2 0/2] Exynos5250 SATA Support
Message-ID: <1384158778-27555-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable the SATA support on Exynos5250 based boards.
It incorporates the generic phy framework to deal with sata phy.

This patch depends on the below patches
	[1]. drivers: phy: add generic PHY framework
		by Kishon Vijay Abraham I<kishon@ti.com>
	[2]. ata: ahci_platform: Manage SATA PHY
		by Roger Quadros <rogerq@ti.com>
	[3]. i2c: s3c2410 : Add polling mode support
		by Vasanth Ananthan <vasanth.a@samsung.com>

Earlier version can be found in the below link:
	http://lwn.net/Articles/568966/

Changes from Version 1:
	1. Dropped the patch 
	ahci: exynos: add ahci sata support on Exynos platform

	2.Adapt to latest generic PHY framework available in 
	git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
 
Yuvaraj Kumar C D (2):
  Phy: Exynos: Add Exynos5250 sata phy driver
  ARM: dts: Enable ahci sata and sata phy

 .../devicetree/bindings/ata/exynos-sata-phy.txt    |   19 +-
 .../devicetree/bindings/ata/exynos-sata.txt        |   17 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |    9 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    8 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   21 +-
 drivers/phy/Kconfig                                |    7 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/exynos5250_phy_i2c.c                   |   43 ++++
 drivers/phy/sata_phy_exynos5250.c                  |  245 ++++++++++++++++++++
 drivers/phy/sata_phy_exynos5250.h                  |   33 +++
 10 files changed, 382 insertions(+), 21 deletions(-)
 create mode 100644 drivers/phy/exynos5250_phy_i2c.c
 create mode 100644 drivers/phy/sata_phy_exynos5250.c
 create mode 100644 drivers/phy/sata_phy_exynos5250.h

-- 
1.7.9.5
