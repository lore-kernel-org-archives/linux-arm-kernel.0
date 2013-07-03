From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Jul 2013 17:50:36 +0800
Subject: [PATCH V2 00/11] ARM: tegra114: add support for system suspend
Message-ID: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduce system suspend function for Tegra114 and depend on
the series of "ARM: tegra114: cpuidle: add power down state".

Verified on Seaboard, Cardhu and Dalmore and with THUMB2_KERNEL as well.

V2:
* do some fixes from the comments in the review

Joseph Lo (11):
  ARM: tegra: do v7_invalidate_l1 only when CPU is Cortex-A9
  ARM: tegra: add a flag for tegra_disable_clean_inv_dcache to do LoUIS
    or ALL
  ARM: tegra114: set up the correct L2 data RAM latency for Cortex-A15
  ARM: tegra114: add low level support code for cluster power down
  ARM: tegra114: shut off the CPU rail when the last CPU in suspend
  ARM: tegra114: hook tegra_tear_down_cpu function
  ARM: tegra114: flowctrl: add support for cpu_suspend_enter/exit
  clk: tegra114: add suspend/resume function for tegra_cpu_car_ops
  ARM: tegra: remove the limitation that Tegra114 can't support suspend
  ARM: dts: tegra114: dalmore: add GPIO power key support
  ARM: dts: tegra114: dalmore: add PM configurations for PMC

 arch/arm/boot/dts/tegra114-dalmore.dts | 18 ++++++++++++++++++
 arch/arm/mach-tegra/flowctrl.c         |  2 ++
 arch/arm/mach-tegra/flowctrl.h         |  7 +++++++
 arch/arm/mach-tegra/headsmp.S          |  3 ++-
 arch/arm/mach-tegra/hotplug.c          |  2 +-
 arch/arm/mach-tegra/pm.c               |  8 +++-----
 arch/arm/mach-tegra/pmc.c              | 16 +++++++++++++++-
 arch/arm/mach-tegra/reset-handler.S    |  8 ++++++--
 arch/arm/mach-tegra/sleep-tegra20.S    |  1 +
 arch/arm/mach-tegra/sleep-tegra30.S    |  7 ++++++-
 arch/arm/mach-tegra/sleep.S            | 29 ++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/sleep.h            |  6 +++++-
 drivers/clk/tegra/clk-tegra114.c       | 26 ++++++++++++++++++++++++++
 13 files changed, 120 insertions(+), 13 deletions(-)

-- 
1.8.3.2
