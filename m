From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:24 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v3.17
Message-ID: <cover.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v3.17.

This pull request is based on 'Renesas ARM Based SoC Header Cleanup for v3.17',
tagged as header-cleanup-for-v3.17, which I have already sent a
pull-request for. 

The following changes since commit 62872989bdbf1245d7239b9f4c05a8ee7c775ed5:

  ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case (2014-06-17 17:09:40 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-for-v3.17

for you to fetch changes up to 3ed66ec5ced8b801cb851b2b8548301df94f8f54:

  ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile (2014-06-23 09:53:55 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v3.17

* Use shmobile_init_late on r8a7791 and r8a7790 whien booting using DT-only
* Support Core-Standby for Suspend to RAM on r8a7791 and r8a7790 SoCs
* Shared CMA reservation for R-Car Gen2 SoCs
* Add r8a7791 SYSC power management support

----------------------------------------------------------------
Benoit Cousson (1):
      ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable

Gaku Inami (1):
      ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile

Geert Uytterhoeven (3):
      ARM: shmobile: rcar-gen2: Update for of_get_flat_dt_prop() update
      ARM: shmobile: rcar-gen2: Use "1ULL" instead of "(u64)1"
      ARM: shmobile: rcar-gen2: Remove useless copied section for LongTrail

Magnus Damm (3):
      ARM: shmobile: Use shmobile_init_late() on r8a7790 DT-only
      ARM: shmobile: Use shmobile_init_late() on r8a7791 DT-only
      ARM: shmobile: Add shared R-Car Gen2 CMA reservation code

Simon Horman (1):
      ARM: shmobile: rcar-gen2: correct return value of shmobile_smp_apmu_suspend_init

Vincent Stehl? (1):
      ARM: shmobile: rcar-gen2: update call to dma_contiguous_reserve_area

keita kobayashi (4):
      ARM: shmobile: r8a7791 SYSC setup code
      ARM: shmobile: APMU: Add Core-Standby-state for Suspend to RAM
      ARM: shmobile: r8a7790: Support Core-Standby for Suspend to RAM
      ARM: shmobile: r8a7791: Support Core-Standby for Suspend to RAM

 arch/arm/mach-shmobile/Kconfig                |  1 +
 arch/arm/mach-shmobile/Makefile               |  1 +
 arch/arm/mach-shmobile/common.h               |  2 +
 arch/arm/mach-shmobile/include/mach/r8a7791.h |  1 +
 arch/arm/mach-shmobile/platsmp-apmu.c         | 60 ++++++++++++++++++++--
 arch/arm/mach-shmobile/pm-r8a7791.c           | 47 +++++++++++++++++
 arch/arm/mach-shmobile/rcar-gen2.h            |  1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |  2 +
 arch/arm/mach-shmobile/setup-r8a7791.c        |  2 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c      | 72 +++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7790.c          |  1 +
 arch/arm/mach-shmobile/smp-r8a7791.c          |  3 ++
 12 files changed, 189 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7791.c
