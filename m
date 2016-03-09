From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  9 Mar 2016 03:32:05 +0000
Subject: [PATCH 0/9] GIC updates for 4.6
Message-ID: <1457494325-13042-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Please find below the GIC updates for 4.6. This time around, the first
round of ACPI support for GICv3, the Alpine MSI widget and a RealView
support update (blast from the past!).

Thanks,

	M.

The following changes since commit fe2f95468e4bdf4a526be4f86efaefe48ca63b83:

  x86/apic: Deinline _flat_send_IPI_mask, save ~150 bytes (2016-03-08 12:26:41 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/gic-4.6

for you to fetch changes up to bc12baf91e0003bb0fd5c6899160dacbd301ca07:

  irqchip: gic/realview: support more RealView DCC variants (2016-03-09 02:45:53 +0000)

----------------------------------------------------------------
GIC updates for 4.6

- Basic GICv3 ACPI support
- Alpine MSI widget on top of GICv3
- More RealView GIC support

----------------------------------------------------------------
Antoine Tenart (3):
      irqchip/gic-v3: always return IRQ_SET_MASK_OK_DONE in gic_set_affinity
      irqchip: add the Alpine MSIX interrupt controller
      Documentation: bindings: document the Alpine MSIX driver

Hanjun Guo (1):
      irqchip/gic-v3: Remove gic_root_node variable from the ITS code

Linus Walleij (1):
      irqchip: gic/realview: support more RealView DCC variants

Tomasz Nowicki (4):
      irqchip/gic-v3: Refactor gic_of_init() for GICv3 driver
      irqchip/gic-v3: Add ACPI support for GICv3/4 initialization
      irqchip/gic-v3: ACPI: Add redistributor support via GICC structures
      irqchip/gic-v3-its: Mark its_init() and its children as __init

 .../interrupt-controller/al,alpine-msix.txt        |  26 ++
 .../bindings/interrupt-controller/arm,gic.txt      |   1 +
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-alpine-msi.c                   | 293 +++++++++++++++++
 drivers/irqchip/irq-gic-realview.c                 |  44 ++-
 drivers/irqchip/irq-gic-v3-its.c                   |  10 +-
 drivers/irqchip/irq-gic-v3.c                       | 349 ++++++++++++++++++---
 8 files changed, 669 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
 create mode 100644 drivers/irqchip/irq-alpine-msi.c
