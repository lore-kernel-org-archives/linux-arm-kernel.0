From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:16:05 +0100
Subject: [PATCH 0/6] irqchip: introduce the Alpine MSIX driver
Message-ID: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series introduce the Alpine MSIX driver, and enables it in both
the Alpine v1 and Alpine v2 device trees.

This series depends on "[PATCH 0/3] arm64: introduce the Alpine support":
https://lkml.org/lkml/2016/2/8/75

You can find the series at:
https://github.com/atenart/linux.git 4.5-rc1/alpinev2-msix

Antoine

Antoine Tenart (6):
  irqchip: add the Alpine MSIX interrupt controller
  Documentation: bindings: document the Alpine MSIX driver
  arm64: dts: alpine: add the MSIX node in the Alpine v2 dtsi
  ARM: dts: alpine: add the MSIX node
  arm64: alpine: select the Alpine MSI controller driver
  arm: alpine: select the Alpine MSI controller driver

 .../interrupt-controller/al,alpine-msix.txt        |  22 ++
 arch/arm/boot/dts/alpine.dtsi                      |  10 +
 arch/arm/mach-alpine/Kconfig                       |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/al/alpine-v2.dtsi              |  10 +
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-alpine-msi.c                   | 297 +++++++++++++++++++++
 8 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
 create mode 100644 drivers/irqchip/irq-alpine-msi.c

-- 
2.7.0
