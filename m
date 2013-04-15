From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 15:52:45 -0400
Subject: [GIT PULL] mvebu irqchip for v3.10
Message-ID: <20130415195245.GU28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

  Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/irqchip-3.10

for you to fetch changes up to 5ec69017cc944f3ed88362d4b60818713a45e616:

  irqchip: armada-370-xp: slightly cleanup irq controller driver (2013-04-15 19:35:17 +0000)

----------------------------------------------------------------
mvebu driver irqchip for v3.10

 - move the armada irqchip driver to drivers/irqchip/

Note:
 - I asked tglx if it was ok to take this series on 10 Apr due to it's complex
   dependencies.  5+ days have passed with no objection.
 - I put this driver in a separate mvebu branch in case tglx or others object,
   it can be dropped with minimal impact to other work.

----------------------------------------------------------------
Thomas Petazzoni (4):
      ARM: mvebu: move L2 cache initialization in init_early()
      irqchip: move IRQ driver for Armada 370/XP
      irqchip: armada-370-xp: move IRQ handler to avoid forward declaration
      irqchip: armada-370-xp: slightly cleanup irq controller driver

 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |   9 +-
 drivers/irqchip/Makefile                           |   1 +
 .../irqchip}/irq-armada-370-xp.c                   | 106 ++++++++++-----------
 4 files changed, 60 insertions(+), 58 deletions(-)
 rename {arch/arm/mach-mvebu => drivers/irqchip}/irq-armada-370-xp.c (91%)
