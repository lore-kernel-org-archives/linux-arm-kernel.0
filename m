From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 10 Feb 2016 14:22:56 +0100
Subject: [PATCH v2 0/7] irqchip: introduce the Alpine MSIX driver
Message-ID: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series introduce the Alpine MSIX driver, and enables it in both
the Alpine v1 and Alpine v2 device trees.

This series depends on "[PATCH v2 0/3] arm64: introduce the Alpine support":
https://lkml.org/lkml/2016/2/10/83

You can find the series at:
https://github.com/atenart/linux.git 4.5-rc1/alpinev2-msix

Antoine

Since v1:
  - Added an interrupt-parent property in the documentation example.
  - Updated to use bitmap_*() instead of *_bit().
  - Removed the static irq_set_affinity to use irq_chip_set_affinity_parent().
  - Updated the address field to use phys_addr_t.
  - Added a comment on why we're setting bit 16 in the address.
  - Patched the gic_set_affinity() function in irqchip/gic-v3.

Antoine Tenart (7):
  irqchip/gic-v3: always return IRQ_SET_MASK_OK_DONE in gic_set_affinity
  irqchip: add the Alpine MSIX interrupt controller
  Documentation: bindings: document the Alpine MSIX driver
  arm64: dts: alpine: add the MSIX node in the Alpine v2 dtsi
  ARM: dts: alpine: add the MSIX node
  arm64: alpine: select the Alpine MSI controller driver
  arm: alpine: select the Alpine MSI controller driver

 .../interrupt-controller/al,alpine-msix.txt        |  24 ++
 arch/arm/boot/dts/alpine.dtsi                      |  10 +
 arch/arm/mach-alpine/Kconfig                       |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/al/alpine-v2.dtsi              |  10 +
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-alpine-msi.c                   | 293 +++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 9 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
 create mode 100644 drivers/irqchip/irq-alpine-msi.c

-- 
2.7.0
