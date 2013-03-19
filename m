From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:19:22 +0900
Subject: [GIT PULL v2] Renesas INTC External IRQ pin driver
Message-ID: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d75bc78b508d0a95d7738290d8ec9923691f4301:

  r8a7779: Add Display Unit clock support (2013-03-18 21:22:34 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git intc-external-irq

for you to fetch changes up to 3b8dfa7c2f8af7613dae28ac0f3419bf75ead5d0:

  irqchip: irqc: Add DT support (2013-03-18 21:26:07 +0900)

----------------------------------------------------------------
Renesas INTC External IRQ pin driver

This provides two new INTC drivers for use with Renesas ARM-based SoCs and
makes use of them on the r8a7779 and sh73a0 SoCs.

It has been agreed by the relevant parties, Thomas Gleixner, Magnus Damm,
and myself that it would be best to merge this code through the renesas
tree and thus through the arm-soc tree.

This is based on:

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-v3.10

----------------------------------------------------------------
Magnus Damm (14):
      irqchip: Renesas INTC External IRQ pin driver
      ARM: shmobile: irq_pin() for static IRQ pin assignment
      ARM: shmobile: INTC External IRQ pin driver on sh73a0
      ARM: shmobile: INTC External IRQ pin driver on r8a7779
      irqchip: intc-irqpin: Whitespace fixes
      irqchip: intc-irqpin: Cache mapped IRQ
      irqchip: intc-irqpin: Add force comments
      irqchip: intc-irqpin: Make use of devm functions
      irqchip: intc-irqpin: GPL header for platform data
      irqchip: Renesas IRQC driver
      ARM: shmobile: Make sh73a0 INTC irqpin platform data static
      ARM: shmobile: Make r8a7779 INTC irqpin platform data static
      irqchip: intc-irqpin: Initial DT support
      irqchip: irqc: Add DT support

 arch/arm/mach-shmobile/Kconfig                     |    2 +
 arch/arm/mach-shmobile/board-kzm9g.c               |   14 +-
 arch/arm/mach-shmobile/include/mach/common.h       |    1 +
 arch/arm/mach-shmobile/include/mach/irqs.h         |    4 +
 arch/arm/mach-shmobile/intc-r8a7779.c              |   53 ++-
 arch/arm/mach-shmobile/intc-sh73a0.c               |  117 -----
 arch/arm/mach-shmobile/setup-sh73a0.c              |  126 ++++++
 drivers/irqchip/Kconfig                            |    8 +
 drivers/irqchip/Makefile                           |    2 +
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  471 ++++++++++++++++++++
 drivers/irqchip/irq-renesas-irqc.c                 |  307 +++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |    6 +-
 .../linux/platform_data/irq-renesas-intc-irqpin.h  |   29 ++
 include/linux/platform_data/irq-renesas-irqc.h     |   27 ++
 14 files changed, 1039 insertions(+), 128 deletions(-)
 create mode 100644 drivers/irqchip/irq-renesas-intc-irqpin.c
 create mode 100644 drivers/irqchip/irq-renesas-irqc.c
 create mode 100644 include/linux/platform_data/irq-renesas-intc-irqpin.h
 create mode 100644 include/linux/platform_data/irq-renesas-irqc.h
