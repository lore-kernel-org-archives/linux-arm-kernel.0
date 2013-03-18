From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Mar 2013 16:09:56 +0800
Subject: [PATCH V2 0/3] ARM: tegra: add clock source for PMC
Message-ID: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series was original introduced to clean up the PM related code after
the system suspending support series. The information about the origianl
patch set is below.

[1/3] ARM: tegra: moving the CPU power timer function to PMC driver
[2/3] ARM: tegra: refactor the pmc_pm_set function
[3/3] ARM: tegra: cpuidle: remove redundant parameters for powered-down mode

I split them up in V2. The [1/3] is integrated into this series. And should
be merged before the system suspending support series.

The [2/3] is squashed into the system suspending support series.

The [3/3] become a stand alone clean up patah right after the system suspending
support series.

Joseph Lo (3):
  ARM: dts: tegra: add clock source for PMC
  ARM: tegra: get PMC clock source from DT
  ARM: tegra: moving the CPU power timer function to PMC driver

 arch/arm/boot/dts/tegra20.dtsi |  1 +
 arch/arm/boot/dts/tegra30.dtsi |  1 +
 arch/arm/mach-tegra/common.c   |  2 +-
 arch/arm/mach-tegra/pm.c       | 37 +------------------------------------
 arch/arm/mach-tegra/pmc.c      | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h      |  4 ++++
 6 files changed, 44 insertions(+), 37 deletions(-)

-- 
1.8.1.5
