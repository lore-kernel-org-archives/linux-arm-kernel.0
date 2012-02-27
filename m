From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 27 Feb 2012 17:36:11 +0100
Subject: [GIT PULL] ARM: OMAP: IRQ domain support for INTC
Message-ID: <4F4BB0FB.3040308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony

This series is based on the lo/dt + the irqdomain/next branch merged on top of it.

Grant confirmed that the irqdomain/next is a stable branch and thus can be referenced for dependency.

Please note that I will need that branch to base all the remaining OMAP DT stuff.

Thanks,
Benoit


The following changes since commit 1f52299ec000e2161635b263d81ab92ea7f1f0a7:
  Benoit Cousson (1):
        Merge branch 'irqdomain/next' of git://git.secretlab.ca/git/linux-2.6 into for_3.4/dt_irq_domain2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_irq_domain

Benoit Cousson (3):
      ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
      arm/dts: OMAP3: Add interrupt-controller bindings for INTC
      ARM: OMAP2+: board-generic: Use of_irq_init API

 .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 +-
 arch/arm/mach-omap2/board-generic.c                |   30 +++++-----
 arch/arm/mach-omap2/common.h                       |   12 ++++
 arch/arm/mach-omap2/irq.c                          |   60 ++++++++++++++++---
 5 files changed, 109 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
