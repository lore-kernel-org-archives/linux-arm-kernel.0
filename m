From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 16:00:57 -0500
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.14
Message-ID: <20131201210057.GW2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

This is a bunch of small changes and cleanup for SoC-wide code.  All has
been in -next for a week.

thx,

Jason.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.14

for you to fetch changes up to b12634e343bea9ce94ed3252fccbac347f8bb37f:

  ARM: mvebu: fix some sparse warnings (2013-11-24 03:27:54 +0000)

----------------------------------------------------------------
mvebu soc changes for v3.14

 - orion:
    - remove IRQF_DISABLED
    - directly include some .h files

 - mvebu:
    - remove some sparse warnings

 - orion5x:
    - include cleanup
    - warning removal for C=1

 - kirkwood:
    - remove legacy clock workarounds
    - stop rpinting a TCLK value of 0 for DT boards

 - dove:
    - warning removal for C=1

----------------------------------------------------------------
Andrew Lunn (3):
      ARM: Orion: Add missing includes
      ARM: Orion5x: Fix warnings when using C=1.
      ARM: Dove: Fix compiler warnings with C=1 builds

Arnaud Patard (1):
      ARM: kirkwood: stop printk TCLK value at boot for DT boards

Jisheng Zhang (1):
      ARM: mvebu: fix some sparse warnings

Michael Opdenacker (1):
      arm: plat-orion: remove deprecated IRQF_DISABLED

Sebastian Hesselbarth (1):
      ARM: kirkwood: remove lagacy clk workarounds

Uwe Kleine-K?nig (1):
      ARM: orion5x: drop unused include from common.c

 arch/arm/mach-dove/common.c                    | 15 ++--------
 arch/arm/mach-kirkwood/board-dt.c              | 40 ++------------------------
 arch/arm/mach-mvebu/coherency.c                |  1 +
 arch/arm/mach-mvebu/coherency.h                |  4 ++-
 arch/arm/mach-mvebu/common.h                   |  1 -
 arch/arm/mach-mvebu/hotplug.c                  |  1 +
 arch/arm/mach-mvebu/platsmp.c                  |  4 +--
 arch/arm/mach-mvebu/pmsu.c                     |  3 +-
 arch/arm/mach-mvebu/system-controller.c        |  5 ++--
 arch/arm/mach-orion5x/board-dt.c               |  2 +-
 arch/arm/mach-orion5x/common.c                 |  7 ++---
 arch/arm/mach-orion5x/db88f5281-setup.c        |  2 +-
 arch/arm/mach-orion5x/irq.c                    |  1 +
 arch/arm/mach-orion5x/pci.c                    |  4 +--
 arch/arm/mach-orion5x/rd88f5182-setup.c        |  2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c |  2 +-
 arch/arm/mach-orion5x/ts209-setup.c            |  2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |  2 +-
 arch/arm/plat-orion/common.c                   |  9 +++---
 arch/arm/plat-orion/time.c                     |  3 +-
 20 files changed, 36 insertions(+), 74 deletions(-)
