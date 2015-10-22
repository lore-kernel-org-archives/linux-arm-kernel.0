From: lftan@altera.com (Ley Foon Tan)
Date: Thu, 22 Oct 2015 17:27:25 +0800
Subject: [PATCH v11 0/6] Altera PCIe host controller driver with MSI support
Message-ID: <1445506051-21688-1-git-send-email-lftan@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the 11th version of patch set to add support for Altera PCIe host
controller with MSI feature on Altera FPGA device families. This patchset
mainly resovle the warning/error caught by kbuild test.

Hi Bjorn,
Do you have further comment on this patchset? Any chance this can go into 4.4?
Thanks.

This patchset is based on v4.3-rc6.

v10->v11 changes:
- altera-pcie: change altera_pcie_fixups to static function
- Kconfig: add depends on ARM || NIOS2 for PCIE_ALTERA

History:
-------
[v1]: https://lkml.org/lkml/2015/7/28/395
[v2]: https://lkml.org/lkml/2015/7/31/267
[v3]: http://www.kernelhub.org/?msg=811940&p=2
[v4]: https://lkml.org/lkml/2015/8/17/141
[v5]: https://lkml.org/lkml/2015/8/25/238
[v6]: https://lkml.org/lkml/2015/9/1/177
[v7]: https://lkml.org/lkml/2015/9/20/193
[v8]: http://www.kernelhub.org/?msg=853553&p=2
[v9]: https://lkml.org/lkml/2015/10/13/998
[v10]: https://lkml.org/lkml/2015/10/19/139

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
 drivers/pci/host/Kconfig                           |  16 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pcie-altera-msi.c                 | 314 +++++++++++
 drivers/pci/host/pcie-altera.c                     | 579 +++++++++++++++++++++
 include/linux/pci_ids.h                            |   2 +
 9 files changed, 1007 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 drivers/pci/host/pcie-altera-msi.c
 create mode 100644 drivers/pci/host/pcie-altera.c

-- 
1.8.2.1
