From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Tue, 24 Mar 2015 13:39:43 +0200
Subject: [RFC 0/3] Introduce msi-x support for alpine platform
Message-ID: <55114cff.C63iVbcCQ4h2DAOU%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC introduces support for msi unit in the alpine platform.
The msi-x unit captures memory writes and triggers interrupts in the GIC.

The patchset is based on pci-support for alpine, introduced in this patchset:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333068.html
For the devicetree property to work, it requires "msi-parent" property to be
supported by pci-host-generic driver, as suggested here:
https://lkml.org/lkml/2014/11/11/795.

Patch #1 enables generic msi support for arm architechture

Patch #2 contains the actual driver and devicetree documentation

Patch #3 adds the device-tree mapping

Tsahee Zidenberg (3):
  ARM: add generic msi support
  ARM alpine: introduce msi-x unit support
  ARM: dts: alpine: add msi-x controller

 .../devicetree/bindings/arm/al/al-msix.txt         |  35 +++
 arch/arm/boot/dts/alpine.dtsi                      |  13 +
 arch/arm/include/asm/msi.h                         |   2 +
 arch/arm/mach-alpine/Kconfig                       |   2 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-alpine-msi.c                   | 291 +++++++++++++++++++++
 6 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/al/al-msix.txt
 create mode 100644 arch/arm/include/asm/msi.h
 create mode 100644 drivers/irqchip/irq-alpine-msi.c

-- 
1.9.1
