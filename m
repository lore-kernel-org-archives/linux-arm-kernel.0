From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Wed, 2 Jul 2014 10:21:05 -0500
Subject: [PATCH 0/3 V2] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
Message-ID: <1404314468-7674-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400 (e.g. gic-400+).

This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
(https://lkml.org/lkml/2014/3/14/320).

Changes in V2:
Re-architect the code to:
    * Use irq_chip for gicv2m instead of using the gic_chip (per Marc suggestion).
    * Remove the overwriting of arch_setup_msi_irq and arch_setup_msi_irqs
      (per Marc suggestion).
    * Add devicetree matching for gic-400-plus for v2m stuff instread of
      re-using gic-400 just to be clear.
    * Misc fix/clean up per Mark Rutland and Marc Zyngier comments

Suravee Suthikulpanit (3):
  irqchip: gic: Add binding probe for ARM GIC400
  irqchip: gic: Restructuring ARM GIC code
  irqchip: gic: Add supports for ARM GICv2m MSI(-X)

 Documentation/devicetree/bindings/arm/gic.txt |  19 +-
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                 | 248 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v2m.h                 |  13 ++
 drivers/irqchip/irq-gic.c                     |  88 +++++----
 drivers/irqchip/irq-gic.h                     |  60 +++++++
 7 files changed, 395 insertions(+), 40 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.h
 create mode 100644 drivers/irqchip/irq-gic.h

-- 
1.9.0
