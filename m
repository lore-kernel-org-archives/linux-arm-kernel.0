From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Apr 2013 23:26:13 +0200
Subject: [PATCHv1 0/5] Marvell EBU irqchip improvements
Message-ID: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a set of 5 patches that move the Marvell EBU IRQ controller
driver to drivers/irqchip/ and do a few minor related cleanup or
improvements.

Those commits were originally part of the series introducing PCIe MSI
support for Marvell EBU platform, but the MSI support is not ready for
merging. However, I'd like those preparation patches to be considered
for 3.10.

Thanks,

Thomas

Thomas Petazzoni (5):
  ARM: mvebu: move L2 cache initialization in init_early()
  irqchip: move IRQ driver for Armada 370/XP
  irqchip: armada-370-xp: move IRQ handler to avoid forward declaration
  irqchip: armada-370-xp: slightly cleanup irq controller driver
  ARM: mvebu: do not duplicate the mpic alias

 arch/arm/boot/dts/armada-370.dtsi                  |    2 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |    2 +-
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    9 +-
 drivers/irqchip/Makefile                           |    1 +
 .../irqchip}/irq-armada-370-xp.c                   |  106 ++++++++++----------
 6 files changed, 62 insertions(+), 60 deletions(-)
 rename {arch/arm/mach-mvebu => drivers/irqchip}/irq-armada-370-xp.c (91%)

-- 
1.7.9.5
