From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 5 Jul 2012 15:25:14 +0530
Subject: [PATCH v3 0/6] Port Tegra to generic clk framework
Message-ID: <1341482120-3317-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set ports Tegra clock code to generic clock framework.

Depends on
[PATCH v3 0/9] Add clk_prepare/clk_unprepare series
[PATCH] ARM: tegra: Remove second instance of uart clk
[PATCH] dma: tegra: add clk_prepare/clk_unprepare
[PATCH] ARM: tegra: dma: rename driver name for clock to "tegra-apbdma"

Depends on following fix currently in clk-fixes for 3.5-rc6
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commit;h=863b13271f1608ab3af6f7a371047d9a66693e38

Tested on Ventana and Cardhu.

v3:
 - Fix Tegra20 pll clk round rate.
 - Fix Tegra30 periph clk ref count check.

v2:
 - Rebased on Tegra's for-3.6/common-clk.

Prashant Gaikwad (6):
  ARM: tegra30: Separate out clk ops and clk data
  ARM: tegra20: Separate out clk ops and clk data
  ARM: tegra: Rename tegra20 clock file
  ARM: tegra: Add clk_tegra structure and helper functions
  ARM: tegra: Port tegra to generic clock framework
  ARM: tegra: Remove duplicate code

 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-tegra/Makefile              |    4 +-
 arch/arm/mach-tegra/clock.c               |  570 +------
 arch/arm/mach-tegra/clock.h               |   40 +-
 arch/arm/mach-tegra/common.c              |    1 -
 arch/arm/mach-tegra/include/mach/clk.h    |    3 +
 arch/arm/mach-tegra/tegra20_clocks.c      | 1526 +++++++++++++++++
 arch/arm/mach-tegra/tegra20_clocks.h      |   41 +
 arch/arm/mach-tegra/tegra20_clocks_data.c | 1113 +++++++++++++
 arch/arm/mach-tegra/tegra2_clocks.c       | 2484 ----------------------------
 arch/arm/mach-tegra/tegra30_clocks.c      | 2559 ++++++++++-------------------
 arch/arm/mach-tegra/tegra30_clocks.h      |   53 +
 arch/arm/mach-tegra/tegra30_clocks_data.c | 1370 +++++++++++++++
 13 files changed, 4991 insertions(+), 4774 deletions(-)
 create mode 100644 arch/arm/mach-tegra/tegra20_clocks.c
 create mode 100644 arch/arm/mach-tegra/tegra20_clocks.h
 create mode 100644 arch/arm/mach-tegra/tegra20_clocks_data.c
 delete mode 100644 arch/arm/mach-tegra/tegra2_clocks.c
 create mode 100644 arch/arm/mach-tegra/tegra30_clocks.h
 create mode 100644 arch/arm/mach-tegra/tegra30_clocks_data.c

-- 
1.7.4.1
