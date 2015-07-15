From: ddaney.cavm@gmail.com (David Daney)
Date: Wed, 15 Jul 2015 09:54:40 -0700
Subject: [PATCH 0/5] arm64, pci: Add ECAM/PCIe support for Cavium ThunderX
Message-ID: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

The subject pretty much says it all.  The first four patches tweak the
infrastructure a little so that we can get required behavior.  The
final patch adds the drivers.

David Daney (5):
  pci: Add is_pcierc element to struct pci_bus
  gic-its: Allow pci_requester_id to be overridden.
  arm64, pci: Allow RC drivers to supply pcibios_add_device()
    implementation.
  irqchip: gic-v3: Add gic_get_irq_domain() to get the irqdomain of the
    GIC.
  PCI: Add host drivers for Cavium ThunderX processors.

 arch/arm64/include/asm/pci.h        |   3 +
 arch/arm64/kernel/pci.c             |  10 +
 drivers/irqchip/irq-gic-v3-its.c    |  14 +-
 drivers/irqchip/irq-gic-v3.c        |   5 +
 drivers/pci/host/Kconfig            |  12 +
 drivers/pci/host/Makefile           |   2 +
 drivers/pci/host/pcie-thunder-pem.c | 462 ++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-thunder.c     | 422 ++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |   2 +
 include/linux/irqchip/arm-gic-v3.h  |   3 +
 include/linux/pci.h                 |   1 +
 11 files changed, 935 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pcie-thunder-pem.c
 create mode 100644 drivers/pci/host/pcie-thunder.c

-- 
1.9.1
