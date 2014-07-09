From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Wed, 9 Jul 2014 18:05:00 -0500
Subject: [PATCH 0/4 V3] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
Message-ID: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400.

This depends on and has been tested with the V7 of"Add support for PCI in AArch64"
(https://lkml.org/lkml/2014/3/14/320).

Changes in V3:
    * Rebase to git://git.infradead.org/users/jcooper/linux.git irqchip/gic
      (per Jason Cooper request)
    * Misc fix/clean up per Mark Rutland comments
    * Minor Clean up in the driver/irqchip/irq-gic-v2m.c: alloc_msi_irqs()
    * Patch 4 is new to the series:
        * Add ARM64-specific version arch_setup_msi_irqs() to allow support
          for Multiple MSI.
        * Add support for Multiple MSI for GICv2m.

Suravee Suthikulpanit (4):
  irqchip: gic: Add binding probe for ARM GIC400
  irqchip: gic: Restructuring ARM GIC code
  irqchip: gic: Add supports for ARM GICv2m MSI(-X)
  irqchip: gicv2m: Add support for multiple MSI for ARM64 GICv2m

 Documentation/devicetree/bindings/arm/gic.txt |  20 +-
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/msi.h                  |  15 ++
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/msi.c                       |  57 +++++
 drivers/irqchip/Kconfig                       |   7 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                 | 331 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v2m.h                 |  13 +
 drivers/irqchip/irq-gic.c                     |  90 ++++---
 drivers/irqchip/irq-gic.h                     |  67 ++++++
 11 files changed, 562 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm64/include/asm/msi.h
 create mode 100644 arch/arm64/kernel/msi.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.h
 create mode 100644 drivers/irqchip/irq-gic.h

-- 
1.9.0
