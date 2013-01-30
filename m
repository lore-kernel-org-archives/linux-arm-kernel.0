From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 14:42:32 -0700
Subject: [GIT PULL 1/8] ARM: tegra: cleanup
Message-ID: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pull request contains various cleanup and minor changes to core
Tegra code:
* Tegra clocksource driver is moved to drivers/clocksource.
* Various typos, warning cleanup, statics cleanup, section mismatch
  fixes, etc.
* Various small fixes/cleanups for CPU/hotplug/SMP code.

This pull request is based on a merge of v3.8-rc3 and at least part of
arm-soc's timer/cleanup branch.

----------------------------------------------------------------

The following changes since commit f3dab3989b4282e448cba0f0708934276dcb413a:

  Merge remote-tracking branch 'korg_arm-soc/timer/cleanup' into for-3.9/cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-cleanup

for you to fetch changes up to 24e30c9417230b359bf6dfeb923e90138df7c112:

  ARM: tegra: fix compile error when disable CPU_IDLE

----------------------------------------------------------------

Hiroshi Doyu (2):
      clocksource: tegra: cosmetic: Fix error message
      ARM: tegra: Make variables static

Joseph Lo (7):
      ARM: tegra30: fix power up sequence for boot_secondary
      ARM: tegra: update the cache maintenance order for CPU shutdown
      ARM: tegra: moving the clock gating procedure to tegra_cpu_kill
      ARM: tegra: clean up the CPUINIT section
      ARM: tegra: make device can run on UP
      ARM: tegra30: make the wait time of CPU power up to proportional to HZ
      ARM: tegra: fix compile error when disable CPU_IDLE

Richard Zhao (1):
      ARM: tegra: cpufreq: move clk_get/put out of function tegra_cpu_init/exit

Stephen Warren (2):
      ARM: tegra: move timer.c to drivers/clocksource/
      ARM: tegra: fix Kconfig warnings when !SMP

 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-tegra/Kconfig                     |    4 +-
 arch/arm/mach-tegra/Makefile                    |    6 +-
 arch/arm/mach-tegra/apbio.c                     |    2 +-
 arch/arm/mach-tegra/board-dt-tegra20.c          |   13 +-
 arch/arm/mach-tegra/board-dt-tegra30.c          |    5 +-
 arch/arm/mach-tegra/board.h                     |    1 -
 arch/arm/mach-tegra/common.c                    |    3 +
 arch/arm/mach-tegra/common.h                    |    1 +
 arch/arm/mach-tegra/cpu-tegra.c                 |   40 +--
 arch/arm/mach-tegra/cpuidle-tegra30.c           |    6 +-
 arch/arm/mach-tegra/flowctrl.c                  |    4 +-
 arch/arm/mach-tegra/headsmp.S                   |  221 ----------------
 arch/arm/mach-tegra/hotplug.c                   |   21 +-
 arch/arm/mach-tegra/platsmp.c                   |   43 +++-
 arch/arm/mach-tegra/pm.c                        |    4 +-
 arch/arm/mach-tegra/reset-handler.S             |  239 ++++++++++++++++++
 arch/arm/mach-tegra/reset.c                     |    2 +-
 arch/arm/mach-tegra/sleep-tegra20.S             |    3 -
 arch/arm/mach-tegra/sleep-tegra30.S             |    3 -
 arch/arm/mach-tegra/sleep.S                     |    4 +-
 arch/arm/mach-tegra/sleep.h                     |    1 +
 arch/arm/mach-tegra/tegra30_clocks_data.c       |    6 +-
 drivers/clocksource/Makefile                    |    1 +
 .../clocksource/tegra20_timer.c                 |    9 +-
 25 files changed, 352 insertions(+), 291 deletions(-)
 create mode 100644 arch/arm/mach-tegra/reset-handler.S
 rename arch/arm/mach-tegra/timer.c => drivers/clocksource/tegra20_timer.c (97%)
