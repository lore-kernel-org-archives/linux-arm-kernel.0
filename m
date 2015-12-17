From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 17 Dec 2015 12:52:03 +0100
Subject: [PATCH V2 00/10] Introduce ACPI world to GICv3 & ITS irqchip
Message-ID: <1450353133-15992-1-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches have been part of:
[PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
https://lkml.org/lkml/2015/7/29/234

Patches base on Suravee's ACPI GICv2m support:
https://lkml.org/lkml/2015/12/10/475

The following git branch contains submitted patches along with
the useful for test patches (mainly ACPI ARM64 PCI support).
https://github.com/semihalf-nowicki-tomasz/linux.git (gicv3-its-acpi-v2)

Series has been tested on Cavium ThunderX 1 socket server.

v1 -> v2
- rebased on top of 4.4-rc4
- use pci_msi_domain_get_msi_rid for requester ID to device ID translation

Hanjun Guo (1):
  irqchip / GICv3: remove gic root node in ITS

Tomasz Nowicki (9):
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
  irqchip / GICv3: Add ACPI support for GICv3+ initialization
  irqchip,GICv3,ACPI: Add redistributor support via GICC structures.
  irqchip, gicv3, its: Mark its_init() and its children as __init
  irqchip/GICv3/ITS: Refator ITS dt init code to prepare for ACPI.
  ARM64, ACPI, PCI: I/O Remapping Table (IORT) initial support.
  irqchip, gicv3, its: Probe ITS in the ACPI way.
  acpi, gicv3, msi: Factor out code that might be reused for ACPI
    equivalent.
  acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain
    initialization.

 drivers/acpi/Kconfig                     |   3 +
 drivers/acpi/Makefile                    |   1 +
 drivers/acpi/iort.c                      | 326 +++++++++++++++++++++++++++++
 drivers/irqchip/Kconfig                  |   1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c |  85 ++++++--
 drivers/irqchip/irq-gic-v3-its.c         | 142 +++++++++----
 drivers/irqchip/irq-gic-v3.c             | 341 ++++++++++++++++++++++++++-----
 drivers/pci/msi.c                        |   3 +
 include/linux/iort.h                     |  38 ++++
 include/linux/irqchip/arm-gic-v3.h       |   2 +-
 10 files changed, 841 insertions(+), 101 deletions(-)
 create mode 100644 drivers/acpi/iort.c
 create mode 100644 include/linux/iort.h

-- 
1.9.1
