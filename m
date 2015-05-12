From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 12 May 2015 23:22:59 +0200
Subject: [PATCH 0/2] PCI: iproc: add bcma PCIe 2.0 controller
Message-ID: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After Ray submitted the PCIe controller for the iProc devices using 
pure device tree this adds support for the devices using bcma to scan 
the bus. This should replaces the driver I initially send for inclusion.

@Ray The driver found in the Broadcom SDK does some more stuff:
* setting up some DMA memory areas
* chaining MPS and MRRS to 512
* PHY changes:
 * "improving" the PCIe jitter 
 * some special initializations for the 3rd PCIe port

For me it works without these additions, but I haven't tested for 
performance or stability or 3rd port. Can you check if this is needed 
at all for the devices found on the market?

Hauke Mehrtens (2):
  PCI: iproc: make of_irq_parse_and_map_pci() configurable
  PCI: iproc: add bcma pcie driver

 drivers/pci/host/Kconfig               |  11 ++++
 drivers/pci/host/Makefile              |   1 +
 drivers/pci/host/pcie-iproc-bcma.c     | 112 +++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-iproc-platform.c |   2 +
 drivers/pci/host/pcie-iproc.c          |   2 +-
 drivers/pci/host/pcie-iproc.h          |   1 +
 6 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pcie-iproc-bcma.c

-- 
2.1.4
