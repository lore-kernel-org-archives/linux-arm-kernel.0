From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 Jan 2014 14:34:34 -0500
Subject: [GIT PULL] ARM: mvebu: fixes for v3.13.x/v3.14-rc1
Message-ID: <20140127193434.GN29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Kevin,

Here's the pull we discussed earlier.  Sorry my "send pull requests"
cron job failed me.

As usual, been in -next (a little long this time ;-) ), incremental from
tags/mvebu-fixes-3.13 to tags/mvebu-fixes-3.13-2 in the mvebu/fixes
branch.

thx,

Jason.

The following changes since commit f8b94beb7e6a374cb0de531b72377c49857b35ca:

  i2c: mv64xxx: Document the newly introduced Armada XP A0 compatible (2014-01-14 02:09:17 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.13-2

for you to fetch changes up to 19e61d41404fe4094c2d54943dbf883d9bbca864:

  ARM: mvebu: fix compilation warning on Armada 370 (i.e. non-SMP) (2014-01-21 00:55:47 +0000)

----------------------------------------------------------------
mvebu fixes for v3.13 (incremental #2)

 - allow building and booting DT and non-DT plat-orion SoCs
 - catch proper return value for kirkwood_pm_init()
 - properly check return of of_iomap to solve boot hangs (mirabox, others)
 - remove a compile warning on Armada 370 with non-SMP.

----------------------------------------------------------------
Arnaud Ebalard (1):
      ARM: mvebu: fix compilation warning on Armada 370 (i.e. non-SMP)

Ezequiel Garcia (1):
      ARM: kirkwood: kirkwood_pm_init() should return void

Gregory CLEMENT (1):
      ARM: mvebu: Fix kernel hang in mvebu_soc_id_init() when of_iomap failed

Sebastian Hesselbarth (1):
      ARM: orion: provide C-style interrupt handler for MULTI_IRQ_HANDLER

 arch/arm/mach-kirkwood/pm.c         |  4 ++--
 arch/arm/mach-mvebu/mvebu-soc-id.c  |  2 +-
 arch/arm/plat-orion/irq.c           | 47 +++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-armada-370-xp.c |  4 ++--
 4 files changed, 52 insertions(+), 5 deletions(-)
