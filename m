From: lftan@altera.com (Ley Foon Tan)
Date: Tue, 28 Jul 2015 18:45:39 +0800
Subject: [PATCH 0/6] Altera PCIe host controller driver with MSI support
Message-ID: <1438080345-7233-1-git-send-email-lftan@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Altera PCIe host controller with MSI feature on
Altera FPGA device families.
Note, the MSI component is a soft IP that external from PCIe port.

It is based on patch series from Marc Zyngier "Per-device MSI domain &
platform MSI" [1] to get rid of struct msi_controller.

[1]: https://lkml.org/lkml/2015/7/23/172

Ley Foon Tan (6):
  arm: add msi.h to Kbuild
  arm: mach-socfpga: enable pci support
  pci:host: Add Altera PCIe host controller driver
  pci: altera: Add Altera PCIe MSI driver
  Documentation: dt-bindings: pci: altera pcie device tree binding
  MAINTAINERS: Add Altera PCIe driver maintainer

 .../devicetree/bindings/pci/altera-pcie-msi.txt    |  27 +
 .../devicetree/bindings/pci/altera-pcie.txt        |  49 ++
 MAINTAINERS                                        |  16 +
 arch/arm/include/asm/Kbuild                        |   1 +
 arch/arm/mach-socfpga/Kconfig                      |   2 +
 drivers/pci/host/Kconfig                           |  16 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pcie-altera-msi.c                 | 318 ++++++++++++
 drivers/pci/host/pcie-altera.c                     | 576 +++++++++++++++++++++
 9 files changed, 1007 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 drivers/pci/host/pcie-altera-msi.c
 create mode 100644 drivers/pci/host/pcie-altera.c

-- 
1.8.2.1
