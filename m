From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 18:44:57 -0700
Subject: [GIT PULL 1/6] omap non-urgent fixes for v3.13 merge window
Message-ID: <pull-1381542299-305003>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-not-urgent-signed

for you to fetch changes up to 8ff875e7f93e900e7a7e78f1c9c05a22b33c27cf:

  ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations. (2013-10-08 11:04:22 -0700)

----------------------------------------------------------------
Fixes for omaps that were not considered urgent for the -rc series.
Just minor build fixes, removal of dead code, and a patch to
use the die ID for increasing boot time entropy.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: OMAP1: fix incorrect placement of __initdata tag

Linus Walleij (1):
      ARM: OMAP2+: throw the die id into the entropy pool

Majunath Goudar (1):
      ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations.

Michael Opdenacker (1):
      ARM: OMAP: remove deprecated IRQF_DISABLED

 arch/arm/mach-omap1/common.h   |  3 +++
 arch/arm/mach-omap1/fpga.c     |  3 +--
 arch/arm/mach-omap1/gpio15xx.c |  8 ++++----
 arch/arm/mach-omap1/gpio16xx.c | 22 +++++++++++-----------
 arch/arm/mach-omap1/gpio7xx.c  | 30 +++++++++++++++---------------
 arch/arm/mach-omap1/pm.c       |  1 -
 arch/arm/mach-omap1/time.c     |  2 +-
 arch/arm/mach-omap1/timer32k.c |  2 +-
 arch/arm/mach-omap2/id.c       | 12 ++++++++++++
 arch/arm/mach-omap2/timer.c    |  2 +-
 arch/arm/plat-omap/dma.c       |  1 -
 11 files changed, 49 insertions(+), 37 deletions(-)
