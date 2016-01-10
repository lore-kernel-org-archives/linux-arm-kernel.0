From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sun, 10 Jan 2016 21:11:25 +0530
Subject: [PATCH 0/3] dra7xx: get pcie working in mainline
Message-ID: <1452440488-28398-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds pdata-quirk mechanism to reset PCIe as a temporary
fix till reset controller driver is added in mainline.

Without this series, a stall is observed if pci dra7xx driver
is enabled.

Kishon Vijay Abraham I (3):
  ARM: DRA7: hwmod: Add reset data for PCIe
  HACK: ARM: DRA7: add pdata-quirks to do reset of PCIe
  HACK: pci: dra7xx: use pdata callbacks to perform reset

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   15 ++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c        |   11 ++++++++++
 arch/arm/mach-omap2/prm7xx.h              |    1 +
 drivers/pci/host/pci-dra7xx.c             |   32 +++++++++++++++++++++++++++++
 include/linux/platform_data/pci-dra7xx.h  |   22 ++++++++++++++++++++
 5 files changed, 81 insertions(+)
 create mode 100644 include/linux/platform_data/pci-dra7xx.h

-- 
1.7.9.5
