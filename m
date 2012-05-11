From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 11 May 2012 20:25:13 +0200
Subject: [GIT PULL] Urgent fixes (for v3.4 if possible) for Renesas ARM-based
 platforms
Message-ID: <201205112025.13478.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit 5fab7b501bf29c08c5b01627b496b6b766bd0165

    ARM / mach-shmobile: Invalidate caches when booting secondary cores

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes

to receive urgent fixes for Renesas ARM-based platforms.  Four of these commits
are fixes of regressions new in 3.4-rc and the last one is necessary for SMP to
work on those systems in general.

Thanks!


 arch/arm/mach-shmobile/board-ag5evm.c        |   22 +---------
 arch/arm/mach-shmobile/board-mackerel.c      |   22 +---------
 arch/arm/mach-shmobile/headsmp.S             |   56 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/include/mach/common.h |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c       |    4 ++
 arch/arm/mach-shmobile/setup-sh73a0.c        |    4 ++
 arch/arm/mach-shmobile/smp-r8a7779.c         |    8 +++-
 arch/arm/mach-shmobile/smp-sh73a0.c          |    7 +++-
 arch/arm/mach-shmobile/timer.c               |    9 ----
 9 files changed, 81 insertions(+), 53 deletions(-)

---------------

Guennadi Liakhovetski (2):
      ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper
      ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper

Kuninori Morimoto (1):
      ARM / mach-shmobile: sh73a0 SMP TWD boot regression fix

Magnus Damm (2):
      ARM / mach-shmobile: r8a7779 SMP TWD boot regression fix
      ARM / mach-shmobile: Invalidate caches when booting secondary cores
