From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 20 May 2013 18:39:23 +0800
Subject: [PATCH V2 0/6] ARM: tegra114: add CPU hotplug support
Message-ID: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra 114 is different with other Tegra SoC chips. It using ARM Cortex-A15
as CPU core and a enhanced flow controller for CPU power control. So
we need to skip some code that was for Contex-A9 and some other support
code that was for other Tegra SoC chips. Then adding the proper power up
and hot plug control for Tegra114.

Verified on Seaboard, Cardhu and Dalmore.

V2:
* Double confirmed the patch set is OK with THUMB2_KERNEL enabled.

Joseph Lo (6):
  ARM: tegra: add an assembly marco to check Tegra SoC ID
  ARM: tegra: skip SCU and PL310 code when CPU is not Cortex-A9
  ARM: tegra: make tegra_resume can work for Tegra114
  ARM: tegra114: add power up sequence for warm boot CPU
  clk: tegra114: implement wait_for_reset and disable_clock for
    tegra_cpu_car_ops
  ARM: tegra114: add CPU hotplug support

 arch/arm/mach-tegra/Makefile        |  1 +
 arch/arm/mach-tegra/flowctrl.h      |  1 +
 arch/arm/mach-tegra/fuse.h          | 22 ++++++++--------
 arch/arm/mach-tegra/hotplug.c       |  2 ++
 arch/arm/mach-tegra/platsmp.c       | 25 +++++++++++++++++-
 arch/arm/mach-tegra/reset-handler.S | 51 +++++++++++++++++++++----------------
 arch/arm/mach-tegra/sleep-tegra30.S | 30 ++++++++++++++++++----
 arch/arm/mach-tegra/sleep.S         |  8 +++---
 arch/arm/mach-tegra/sleep.h         | 35 ++++++++++++++++++++-----
 drivers/clk/tegra/clk-tegra114.c    | 23 ++++++++++++++++-
 10 files changed, 150 insertions(+), 48 deletions(-)

-- 
1.8.2.2
