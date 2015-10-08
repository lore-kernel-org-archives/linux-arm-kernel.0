From: lftan@altera.com (Ley Foon Tan)
Date: Thu, 8 Oct 2015 17:43:08 +0800
Subject: [PATCH v8 0/6] Altera PCIe host controller driver with MSI support
Message-ID: <1444297394-3122-1-git-send-email-lftan@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the 8th version of patch set to add support for Altera PCIe host
controller with MSI feature on Altera FPGA device families. This patchset
mainly resolve comments from Rob Herring and Marc Zyngier in v7 and minor fix.

This patchset is based on v4.3-rc3.

v7->v8 changes:
- pcie-altera/Documentation: change to support one case of reg-names.
- Documentation: remove <1> for msi-controller.
- pci: remove depends on ARCH_SOCFPGA and NIOS2 in Kconfig
- pci: change PCIE_ALTERA to bool in Kconfig. It requires pci fixups to work correctly,
       so it needs to be builtin module.

History:
-------
[v1]: https://lkml.org/lkml/2015/7/28/395
[v2]: https://lkml.org/lkml/2015/7/31/267
[v3]: http://www.kernelhub.org/?msg=811940&p=2
[v4]: https://lkml.org/lkml/2015/8/17/141
[v5]: https://lkml.org/lkml/2015/8/25/238
[v6]: https://lkml.org/lkml/2015/9/1/177
[v7]: https://lkml.org/lkml/2015/9/20/193

Ley Foon Tan (6):
  arm: add msi.h to Kbuild
  pci: add Altera PCI vendor ID
  pci:host: Add Altera PCIe host controller driver
  pci: altera: Add Altera PCIe MSI driver
  Documentation: dt-bindings: pci: altera pcie device tree binding
  MAINTAINERS: Add Altera PCIe and MSI drivers maintainer

 .../devicetree/bindings/pci/altera-pcie-msi.txt    |  28 +
 .../devicetree/bindings/pci/altera-pcie.txt        |  49 ++
 MAINTAINERS                                        |  16 +
 arch/arm/include/asm/Kbuild                        |   1 +
 drivers/pci/host/Kconfig                           |  15 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pcie-altera-msi.c                 | 310 +++++++++++
 drivers/pci/host/pcie-altera.c                     | 588 +++++++++++++++++++++
 include/linux/pci_ids.h                            |   2 +
 9 files changed, 1011 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 drivers/pci/host/pcie-altera-msi.c
 create mode 100644 drivers/pci/host/pcie-altera.c

-- 
1.8.2.1
