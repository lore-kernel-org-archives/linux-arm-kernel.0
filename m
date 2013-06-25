From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 25 Jun 2013 17:27:44 +0800
Subject: [PATCH 00/11] ARM: tegra114: add support for system suspend
Message-ID: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduce system suspend function for Tegra114 and depend on
the series of "ARM: tegra114: cpuidle: add power down state".

Verified on Seaboard, Cardhu and Dalmore and with THUMB2_KERNEL as well.

Joseph Lo (11):
  ARM: tegra: do v7_invalidate_l1 only when CPU is Cortex-A9 in
    tegra_resume
  ARM: tegra: add a flag for tegra_disable_clean_inv_dcache to do LoUIS
    or ALL
  ARM: tegra114: set up the correct L2 data RAM latency for Cortex-A15
  ARM: tegra114: add low level support code for cluster power down
  ARM: tegra114: shut off the CPU rail when the last CPU in suspend
  ARM: tegra114: hook tegra_tear_down_cpu function
  ARM: tegra114: flowctrl: add support for cpu_suspend_enter/exit
  clk: tegra114: add suspend/resume function for tegar_cpu_car_ops
  ARM: tegar: remove the limitation that Tegra114 can't support suspend
  ARM: dts: tegra114: dalmore: add GPIO power key support
  ARM: dts: tegra114: dalmore: add PM configurations for PMC

 arch/arm/boot/dts/tegra114-dalmore.dts | 18 ++++++++++++++++++
 arch/arm/mach-tegra/flowctrl.c         |  2 ++
 arch/arm/mach-tegra/flowctrl.h         |  7 +++++++
 arch/arm/mach-tegra/hotplug.c          |  2 +-
 arch/arm/mach-tegra/pm.c               |  5 +----
 arch/arm/mach-tegra/pmc.c              | 10 ++++++++++
 arch/arm/mach-tegra/reset-handler.S    |  8 ++++++--
 arch/arm/mach-tegra/sleep-tegra20.S    |  1 +
 arch/arm/mach-tegra/sleep-tegra30.S    |  7 ++++++-
 arch/arm/mach-tegra/sleep.S            | 29 ++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/sleep.h            |  6 +++++-
 drivers/clk/tegra/clk-tegra114.c       | 26 ++++++++++++++++++++++++++
 12 files changed, 111 insertions(+), 10 deletions(-)

-- 
1.8.3.1
