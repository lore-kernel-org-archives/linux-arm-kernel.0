From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 29 Aug 2017 16:19:26 +0200
Subject: [PATCH 0/3] Tango PCIe host bridge MSI support + required API
Message-ID: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn, Marc,

This patch-set includes
	[PATCH v11] PCI: tango: Add MSI controller support
with the doorbell address parsed from DT instead of hard-coded
in the driver.

A wrapper to parse dma-ranges was added to drivers/of/address.c

A few drivers were converted to use the new wrapper.

Marc Gonzalez (3):
  of/pci: Add dma-ranges parsing support
  PCI: Use of_pci_dma_range_parser_init API
  PCI: tango: Add MSI controller support

 drivers/of/address.c             |  19 +++-
 drivers/pci/host/pci-ftpci100.c  |  20 +---
 drivers/pci/host/pci-rcar-gen2.c |  20 +---
 drivers/pci/host/pci-xgene.c     |  20 +---
 drivers/pci/host/pcie-iproc.c    |  20 +---
 drivers/pci/host/pcie-rcar.c     |  20 +---
 drivers/pci/host/pcie-tango.c    | 205 ++++++++++++++++++++++++++++++++++++++-
 include/linux/of_address.h       |  10 +-
 8 files changed, 232 insertions(+), 102 deletions(-)

-- 
2.11.0
