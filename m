From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 31 May 2017 15:28:50 +0200
Subject: [PATCH v5 0/3] Tango PCIe controller support
Message-ID: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spin v5 to address comments from Marc and Bjorn.

Changes from v4 to v5

- Split the DT binding into a third patch
- Introduce host bridge support first
- Put all MSI stuff in the MSI patch
- Inline 2 single-use functions
- Fix tango_ack
- Allocate irq at probe start
- Print dire message in probe, and taint kernel
	("Lasciate ogne speranza, voi ch'intrate")

Marc Gonzalez (3):
  PCI: Add DT binding for tango PCIe controller
  PCI: Add tango PCIe host bridge support
  PCI: Add tango MSI controller support

 Documentation/devicetree/bindings/pci/tango-pcie.txt |  30 +++
 drivers/pci/host/Kconfig                             |   8 +
 drivers/pci/host/Makefile                            |   1 +
 drivers/pci/host/pcie-tango.c                        | 386 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h                              |   2 +
 5 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/host/pcie-tango.c

-- 
2.11.0
