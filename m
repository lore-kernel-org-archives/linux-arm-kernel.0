From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 24 Jun 2012 22:06:16 +0200
Subject: [GIT PULL] Fixes (for v3.5 if possible) for Renesas ARM-based
 platforms
Message-ID: <201206242206.16398.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71

    Linux 3.5-rc3

with top-most commit 86f887c105b909a2cea7b06f2136d66b3438b038

    ARM: shmobile: r8a7779: Route all interrupts to ARM

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes

to receive fixes for Renesas ARM-based platforms for 3.5.  Included are:

* sh7372 and sh73a0 register definition fixes from Kuninori Morimoto.
* SMP build regression fix for EMEV2 not set from Nobuhiro Iwamatsu.
* GPIO IRQ configuration fix for the Mackerel board from Guennadi Liakhovetski.
* Initialization regression fixes for kzm9d, kzm9g and armadillo800eva from
  Laurent Pinchart and Kuninori Morimoto.
* r8a7779 interrupt routing fix from Phil Edworthy.

Thanks!


 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 arch/arm/mach-shmobile/board-kzm9d.c           | 1 +
 arch/arm/mach-shmobile/board-kzm9g.c           | 1 +
 arch/arm/mach-shmobile/board-mackerel.c        | 3 +++
 arch/arm/mach-shmobile/clock-sh73a0.c          | 8 ++++----
 arch/arm/mach-shmobile/intc-r8a7779.c          | 7 +++++++
 arch/arm/mach-shmobile/platsmp.c               | 5 +++++
 arch/arm/mach-shmobile/setup-sh7372.c          | 2 +-
 8 files changed, 23 insertions(+), 5 deletions(-)

---------------

Guennadi Liakhovetski (1):
      ARM: mach-shmobile: add missing GPIO IRQ configuration on mackerel

Kuninori Morimoto (4):
      ARM: shmobile: sh73a0: bugfix: SY-DMAC number
      ARM: shmobile: sh7372: bugfix: chclr_offset base
      ARM: shmobile: kzm9g: use late init machine hook
      ARM: shmobile: kzm9d: use late init machine hook

Laurent Pinchart (1):
      ARM: mach-shmobile: armadillo800eva: Use late init machine hook

Nobuhiro Iwamatsu (1):
      ARM: mach-shmobile: Fix build when SMP is enabled and EMEV2 is not enabled

Phil Edworthy (1):
      ARM: shmobile: r8a7779: Route all interrupts to ARM
