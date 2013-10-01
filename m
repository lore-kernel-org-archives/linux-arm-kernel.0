From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Tue,  1 Oct 2013 12:03:00 +0530
Subject: [PATCH 0/3] Exynos5250 SATA Support
Message-ID: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the SATA support on exynos5250 SOC.Also it 
uses generic phy framework patch[1] posted by Kishon Vijay 
Abraham I. 
	[1].drivers: phy: add generic PHY framework.

Yuvaraj Kumar C D (3):
  ahci: exynos: add ahci sata support on Exynos platform
  Phy: Exynos: Add Exynos5250 sata phy driver
  ARM: dts: Enable ahci sata and sata phy

 arch/arm/boot/dts/exynos5250-arndale.dts  |    9 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    6 +-
 arch/arm/boot/dts/exynos5250.dtsi         |   21 ++-
 drivers/ata/Kconfig                       |    9 ++
 drivers/ata/Makefile                      |    1 +
 drivers/ata/ahci_exynos.c                 |  226 ++++++++++++++++++++++++++
 drivers/phy/Kconfig                       |    6 +
 drivers/phy/Makefile                      |    1 +
 drivers/phy/exynos/Kconfig                |    5 +
 drivers/phy/exynos/Makefile               |    5 +
 drivers/phy/exynos/exynos5250_phy_i2c.c   |   53 ++++++
 drivers/phy/exynos/sata_phy_exynos5250.c  |  248 +++++++++++++++++++++++++++++
 drivers/phy/exynos/sata_phy_exynos5250.h  |   33 ++++
 13 files changed, 613 insertions(+), 10 deletions(-)
 create mode 100644 drivers/ata/ahci_exynos.c
 create mode 100644 drivers/phy/exynos/Kconfig
 create mode 100644 drivers/phy/exynos/Makefile
 create mode 100644 drivers/phy/exynos/exynos5250_phy_i2c.c
 create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.c
 create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.h

-- 
1.7.9.5
