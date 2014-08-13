From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Wed, 13 Aug 2014 10:00:39 -0500
Subject: [PATCH 0/2 V4] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
Message-ID: <1407942041-3291-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400.

This depends on and has been tested with the V7 of"Add support for PCI in AArch64"
(https://lkml.org/lkml/2014/3/14/320).

Changes in V4:
    * Rebase to git://git.infradead.org/users/jcooper/linux.git irqchip/core
    * Remove patch 2 from previous version
    * Merge patch 1 and 3 from previous version
    * Reworks the GICv2m initialization based on Marc Zyngier review comments.
    * Introduce "v2m" subnode in GIC binding
    * Moves the "struct msi_chip" from "struct gic_chip_data" to "struct v2m_data".

Suravee Suthikulpanit (2):
  irqchip: gic: Add supports for ARM GICv2m MSI(-X)
  irqchip: gicv2m: Add support for multiple MSI for ARM64 GICv2m

 Documentation/devicetree/bindings/arm/gic.txt |  32 +++
 arch/arm64/include/asm/msi.h                  |  15 ++
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/msi.c                       |  57 +++++
 drivers/irqchip/Kconfig                       |   7 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                 | 294 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c                     |  75 ++++---
 drivers/irqchip/irq-gic.h                     |  48 +++++
 9 files changed, 500 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/include/asm/msi.h
 create mode 100644 arch/arm64/kernel/msi.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic.h

-- 
1.9.0
