From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 9 Jan 2012 14:57:17 +0100
Subject: [GIT PULL] ARM: OMAP2+: Interrupt controllers adaptation to DT
Message-ID: <4F0AF23D.9040103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

If this is not too late, could you please pull the OMAP interrupt controllers adaptation to device tree?

This series is based on your lo/dt branch to get the DTS and board cleanup.

Thanks,
Benoit


The following changes since commit 40c0591f0a349ec074357e05c6ab1a3bc951807c:
  Benoit Cousson (1):
        ARM: OMAP2+: kconfig: Enable devicetree by default for OMAP2+ systems

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.3/dt_irq

Benoit Cousson (5):
      arm/dts: OMAP4: Update DTS file with new GIC bindings
      ARM: OMAP2/3: intc: Add irqdomain support
      ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
      arm/dts: OMAP3: Add interrupt-controller bindings for INTC
      ARM: OMAP2+: board-generic: Use of_irq_init API

 .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 ++-
 arch/arm/boot/dts/omap4.dtsi                       |    2 +-
 arch/arm/mach-omap2/board-generic.c                |   30 +++++++------
 arch/arm/mach-omap2/common.h                       |   10 ++++
 arch/arm/mach-omap2/irq.c                          |   48 ++++++++++++++++++--
 6 files changed, 102 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
