From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:20:04 +0800
Subject: [PATCH 0/7] ARM: tegra: support LP1 suspend mode for Tegra124
Message-ID: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the LP1 support for Tegra124. (suspend to LP2 also
supported in this series)

Note:
This patch series depends on the patch series below.
* [PATCH 0/5] Tegra124 clock support
* [PATCH V2 0/6] ARM: tegra: basic support for Tegra124 SoC
* [PATCH] ARM: tegra: add clock properties for devices of Tegra124
* [PATCH 0/4] ARM: tegra: add CPU hot-plug and idle support for Tegra124

Verified on Cardhu, Dalmore and Venice2 and with THUMB2_KERNEL as well.

Joseph Lo (7):
  clk: tegra124: add suspend/resume function for tegra_cpu_car_ops
  ARM: tegra: add flow controller to support suspend for Tegra124
  ARM: tegra: hook tegra_cpu_tear_down for Tegra124
  ARM: tegra: add LP1 support code for Tegra124
  ARM: tegra: hook the LP1 iram code area and sleep_core function for
    Tegra124
  ARM: tegra: enable Tegra RTC for Venice2
  ARM: tegra: enable LP1 suspend mode for Venice2

 arch/arm/boot/dts/tegra124-venice2.dts | 11 +++++++++++
 arch/arm/mach-tegra/Makefile           |  1 +
 arch/arm/mach-tegra/flowctrl.c         |  2 ++
 arch/arm/mach-tegra/iomap.h            |  3 +++
 arch/arm/mach-tegra/pm.c               | 12 +++++++++---
 arch/arm/mach-tegra/sleep-tegra30.S    | 36 +++++++++++++++++++++++++++-------
 drivers/clk/tegra/clk-tegra124.c       | 27 +++++++++++++++++++++++++
 7 files changed, 82 insertions(+), 10 deletions(-)

-- 
1.8.4
