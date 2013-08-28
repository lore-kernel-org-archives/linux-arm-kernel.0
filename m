From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:41:59 +0900
Subject: [GIT PULL 0/5] Second Round of Renesas ARM based SoC SMP updates for
 v3.12
Message-ID: <cover.1377651075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM based SoC SMP updates for
v3.12.

It is based on renesas-smp-for-v3.12 ("ARM based SoC SMP updates for
v3.12") which you have previously pulled.

I apologise that this and other pull requests that I will send today
are rather later in the cycle than I would like. This is primarily due
to a combination of my summer vacation and wanting to let the patches
sit in next for a while.


The following changes since commit 1d33a354bbb618ba578bb372ebc18fe58457f6f3:

  ARM: shmobile: Per-CPU SMP boot / sleep code for SCU SoCs (2013-08-06 18:07:26 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-smp2-for-v3.12

for you to fetch changes up to c46a8cdf3e1ce9a79f58dca178da9e83138c0c01:

  ARM: shmobile: Introduce shmobile_boot_size (2013-08-21 17:53:34 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC SMP updates for v3.12

A continuation of Magnus's ongoing re-working of SMP on shmobile:
* Introduce shmobile_boot_size
* Expose shmobile_invalidate_start()
* Remove unused shmobile_smp_init_cpus()
* Introduce shmobile_smp_cpu_disable() and use on sh73a0 SoC

----------------------------------------------------------------
Magnus Damm (5):
      ARM: shmobile: Introduce shmobile_smp_cpu_disable()
      ARM: shmobile: Use shmobile_smp_cpu_disable() on sh73a0
      ARM: shmobile: Remove unused shmobile_smp_init_cpus()
      ARM: shmobile: Expose shmobile_invalidate_start()
      ARM: shmobile: Introduce shmobile_boot_size

 arch/arm/mach-shmobile/headsmp.S             |  3 +++
 arch/arm/mach-shmobile/include/mach/common.h |  4 +++-
 arch/arm/mach-shmobile/platsmp.c             | 22 +++++++---------------
 arch/arm/mach-shmobile/smp-sh73a0.c          |  9 +--------
 4 files changed, 14 insertions(+), 24 deletions(-)
