From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:58:35 +0800
Subject: [PATCH V2 0/4] 
Message-ID: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the LP1 support for Tegra124. (suspend to LP2 also
supported in this series)

Note:
This patch series depends on the patch series below.
* [PATCH 0/5] Tegra124 clock support
* [PATCH V2 0/6] ARM: tegra: basic support for Tegra124 SoC
* [PATCH] ARM: tegra: add clock properties for devices of Tegra124
* [PATCH] ARM: tegra: enable Tegra RTC as default for Tegra124
* [PATCH 0/4] ARM: tegra: add CPU hot-plug and idle support for Tegra124

Verified on Cardhu, Dalmore and Venice2 and with THUMB2_KERNEL as well.

V2:
* remove the patch of "enable Tegra RTC for Venice2"
* add new patch of "re-calculate the LP1 data for Tegra30/114"
* squash the 2 to 5 into patch 3/4 of this series

Joseph Lo (4):
  clk: tegra124: add suspend/resume function for tegra_cpu_car_ops
  ARM: tegra: re-calculate the LP1 data for Tegra30/114
  ARM: tegra: add LP1 support code for Tegra124
  ARM: tegra: enable LP1 suspend mode for Venice2

 arch/arm/boot/dts/tegra124-venice2.dts |  7 +++++
 arch/arm/mach-tegra/Makefile           |  1 +
 arch/arm/mach-tegra/flowctrl.c         |  2 ++
 arch/arm/mach-tegra/iomap.h            |  3 +++
 arch/arm/mach-tegra/pm.c               | 12 ++++++---
 arch/arm/mach-tegra/sleep-tegra30.S    | 49 +++++++++++++++++++++++++---------
 drivers/clk/tegra/clk-tegra124.c       | 27 +++++++++++++++++++
 7 files changed, 86 insertions(+), 15 deletions(-)

-- 
1.8.4
