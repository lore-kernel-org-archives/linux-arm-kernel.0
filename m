From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:35 +0900
Subject: [GIT PULL 00/14] Renesas ARM based SoC SMP updates for v3.13
Message-ID: <cover.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider these Renesas ARM based SoC SMP updates for v3.13.

This pull-request is based on renesas-cleanups-v3.13 which
I has also sent a pull-request for today. The reason for choosing
that base is to reduce conflicts.


The following changes since commit cde214a890f81797a5eee94fffc89c1de21ed991:

  ARM: shmobile: r8a7790: Constify platform data and resources (2013-09-19 14:33:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-smp-for-v3.13

for you to fetch changes up to 43651b15de94d6a5e188ea032311e9661ec708d2:

  ARM: shmobile: Include CA7 cores in APMU table (2013-09-30 17:56:11 +0900)

----------------------------------------------------------------
Renesas ARM based SoC SMP updates for v3.13

* Add CPU notifier based SCU boot vector code
  - Use on emev2, r8a7779 and sh73a0 SoCs
  - Remove now unused shmobile_smp_scu_boot_secondary()
* Add shared APMU SMP support code
  - Use to add SMP support for r8a7790 SoC
* Introduce shmobile_boot_size
* Expose shmobile_invalidate_start()
* Introduce shmobile_smp_cpu_disable()
  - Use on sh73a0 SoC
  - Remove now unused shmobile_smp_init_cpus()

----------------------------------------------------------------
Magnus Damm (14):
      ARM: shmobile: Introduce shmobile_smp_cpu_disable()
      ARM: shmobile: Use shmobile_smp_cpu_disable() on sh73a0
      ARM: shmobile: Remove unused shmobile_smp_init_cpus()
      ARM: shmobile: Expose shmobile_invalidate_start()
      ARM: shmobile: Introduce shmobile_boot_size
      ARM: shmobile: Shared APMU SMP support code without DT
      ARM: shmobile: Add r8a7790 SMP support using APMU code
      ARM: shmobile: Add CPU notifier based SCU boot vector code
      ARM: shmobile: Let sh73a0 rely on SCU CPU notifier
      ARM: shmobile: Let EMEV2 rely on SCU CPU notifier
      ARM: shmobile: Let r8a7779 rely on SCU CPU notifier
      ARM: shmobile: Remove shmobile_smp_scu_boot_secondary()
      ARM: shmobile: Extend APMU code to allow single cluster only
      ARM: shmobile: Include CA7 cores in APMU table

 arch/arm/mach-shmobile/Makefile                |   1 +
 arch/arm/mach-shmobile/board-lager-reference.c |   1 +
 arch/arm/mach-shmobile/board-lager.c           |   1 +
 arch/arm/mach-shmobile/headsmp.S               |   3 +
 arch/arm/mach-shmobile/include/mach/common.h   |  12 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h  |   1 +
 arch/arm/mach-shmobile/platsmp-apmu.c          | 195 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-scu.c           |  30 +++-
 arch/arm/mach-shmobile/platsmp.c               |  22 +--
 arch/arm/mach-shmobile/setup-r8a7790.c         |   1 +
 arch/arm/mach-shmobile/smp-emev2.c             |   6 -
 arch/arm/mach-shmobile/smp-r8a7779.c           |   4 -
 arch/arm/mach-shmobile/smp-r8a7790.c           |  67 +++++++++
 arch/arm/mach-shmobile/smp-sh73a0.c            |  14 +-
 14 files changed, 310 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/platsmp-apmu.c
 create mode 100644 arch/arm/mach-shmobile/smp-r8a7790.c
