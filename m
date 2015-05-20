From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 20 May 2015 14:21:38 +0800
Subject: [RFC PATCH v1 0/3] PCI: hisi: Add PCIe host support for Hisilicon Soc
 Hip05
Message-ID: <1432102901-186201-1-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds PCIe host support for Hisilicon Soc Hip05. The PCIe hosts
use PCIe IP core from Synopsys, So this driver is base on designware PCIe driver.

Hip05 is an ARMv8 architecture Soc. It should be able to use ARM64 PCIe API in
designeware PCIe driver. Following Arnd's suggestion[1], just try to unify
ARM32 and ARM64 PCIe in designware driver.

This patchset is based on v4.1-rc1.

Change from RFC:
1. delete dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
   merge related operations into dw_pcie_host_init.

[1] http://www.spinics.net/lists/devicetree/msg76463.html
Zhou Wang (3):
  PCI: designware: Add ARM64 support
  PCI: hisi: Add PCIe host support for Hisilicon Soc Hip05
  Documentation: DT: Add hisilicon PCIe host binding

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  46 ++++
 drivers/pci/host/Kconfig                           |   5 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-designware.c                 | 128 ++++-------
 drivers/pci/host/pcie-hisi.c                       | 252 +++++++++++++++++++++
 5 files changed, 354 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 drivers/pci/host/pcie-hisi.c

-- 
1.9.1
