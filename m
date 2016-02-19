From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Feb 2016 15:09:46 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.5
Message-ID: <cover.1455859965.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.5.

This pull request is comprised of patches from Geert Uytterhoeven to avoid
writing to .text.

* "ARM: shmobile: Move shmobile_scu_base from .text to .bss"

  Resolves a problem for XIP kernels as writing to .text is not allowed.
  For non-XIP kernels a problem does not manifst as the pages are mapped
  read-only during late kernel startup.

* The remaining patches resolve a kernel-crash that occurs during system
  suspend for CONFIG_DEBUG_RODATA=y kernels.


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-fixes-for-v4.5

for you to fetch changes up to 901c5ffaaed117a38be9d0c29247c4888d6c8636:

  ARM: shmobile: Remove shmobile_boot_arg (2016-02-17 18:27:21 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.5

* Avoid writing to .text

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: Move shmobile_scu_base from .text to .bss
      ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup code
      ARM: shmobile: Move shmobile_smp_{mpidr, fn, arg}[] from .text to .bss
      ARM: shmobile: Remove shmobile_boot_arg

 arch/arm/mach-shmobile/common.h       |  1 -
 arch/arm/mach-shmobile/headsmp-scu.S  |  6 ------
 arch/arm/mach-shmobile/headsmp.S      | 28 ++++++++++++++++------------
 arch/arm/mach-shmobile/platsmp-apmu.c |  1 -
 arch/arm/mach-shmobile/platsmp-scu.c  |  4 +++-
 arch/arm/mach-shmobile/smp-r8a7779.c  |  2 --
 6 files changed, 19 insertions(+), 23 deletions(-)
