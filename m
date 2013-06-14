From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Jun 2013 10:37:17 -0600
Subject: [GIT PULL 4/5] ARM: tegra: core SoC support enhancements
In-Reply-To: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
References: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1371227838-18764-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains fixes and enhancement for core Tegra Soc support:
* CPU hotplug support for Tegra114.
* Some preliminary work on Tegra114 CPU sleep modes.
* Minor fix for EMC table DT parsing.

This branch is based on v3.10-rc1.

----------------------------------------------------------------

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.11-soc

for you to fetch changes up to 8f6a0b6528820f9efec36e5843181cc178fa9de8:

  ARM: tegra: don't pass CPU ID to tegra_{set,clear}_cpu_in_lp2

----------------------------------------------------------------

Dmitry Osipenko (1):
      ARM: tegra: emc: correction of ram-code parsing from dt

Joseph Lo (12):
      ARM: tegra: add an assembly marco to check Tegra SoC ID
      ARM: tegra: skip SCU and PL310 code when CPU is not Cortex-A9
      ARM: tegra: make tegra_resume can work for Tegra114
      ARM: tegra114: add power up sequence for warm boot CPU
      clk: tegra114: implement wait_for_reset and disable_clock for tegra_cpu_car_ops
      ARM: tegra114: add CPU hotplug support
      ARM: tegra: add cpu_disable for hotplug
      ARM: tegra: remove ifdef in the tegra_resume
      ARM: tegra: cpuidle: move the init function behind the suspend init function
      ARM: tegra: hook tegra_tear_down_cpu function in the PM suspend init function
      ARM: tegra: cpuidle: using IS_ENABLED for multi SoCs management in init func
      ARM: tegra: don't pass CPU ID to tegra_{set,clear}_cpu_in_lp2

 arch/arm/mach-tegra/Makefile          |  1 +
 arch/arm/mach-tegra/common.c          |  2 ++
 arch/arm/mach-tegra/common.h          |  1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c | 10 ++----
 arch/arm/mach-tegra/cpuidle-tegra30.c | 10 ++----
 arch/arm/mach-tegra/cpuidle.c         | 19 ++++-------
 arch/arm/mach-tegra/cpuidle.h         | 15 ++-------
 arch/arm/mach-tegra/flowctrl.h        |  1 +
 arch/arm/mach-tegra/fuse.h            | 22 +++++++------
 arch/arm/mach-tegra/hotplug.c         | 13 ++++++++
 arch/arm/mach-tegra/platsmp.c         | 26 ++++++++++++++-
 arch/arm/mach-tegra/pm.c              | 25 ++++++++++++---
 arch/arm/mach-tegra/pm.h              |  4 +--
 arch/arm/mach-tegra/reset-handler.S   | 51 ++++++++++++++++--------------
 arch/arm/mach-tegra/sleep-tegra30.S   | 30 +++++++++++++++---
 arch/arm/mach-tegra/sleep.S           |  8 +++--
 arch/arm/mach-tegra/sleep.h           | 35 ++++++++++++++++----
 arch/arm/mach-tegra/tegra2_emc.c      |  2 +-
 drivers/clk/tegra/clk-tegra114.c      | 23 +++++++++++++-
 19 files changed, 204 insertions(+), 94 deletions(-)
