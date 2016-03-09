From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  9 Mar 2016 09:45:20 +0000
Subject: [PULL #2] GIC updates for 4.6
Message-ID: <1457516720-25639-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Fixed subject and a few patch titles, sorry for the noise...]

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

for you to fetch changes up to 82b0a434b436f5da69ddd24bd6a6fa5dc4484310:

  irqchip/gic/realview: Support more RealView DCC variants (2016-03-09 09:38:05 +0000)

----------------------------------------------------------------
GIC updates for 4.6

- Basic GICv3 ACPI support
- Alpine MSI widget on top of GICv3
- More RealView GIC support

----------------------------------------------------------------
Antoine Tenart (3):
      irqchip/gic-v3: Always return IRQ_SET_MASK_OK_DONE in gic_set_affinity
      irqchip: Add the Alpine MSIX interrupt controller
      Documentation/bindings: Document the Alpine MSIX driver

Hanjun Guo (1):
      irqchip/gic-v3: Remove gic_root_node variable from the ITS code

Linus Walleij (1):
      irqchip/gic/realview: Support more RealView DCC variants

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
