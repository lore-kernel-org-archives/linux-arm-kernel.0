From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 3 Jun 2013 19:17:43 +0800
Subject: [PATCH 0/4] ARM: tegra: cpuidle: some clean up for CPUidle driver
Message-ID: <1370258267-30184-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series has some clean ups for Tegra CPUidle drivers. Also make it
more gereric.

Tested on Seaboard, Cardhu and Dalmore.

Joseph Lo (4):
  ARM: tegra: cpuidle: move the init function behind the suspend init
    function
  ARM: tegra: hook tegra_tear_down_cpu function in the PM suspend init
    function
  ARM: tegra: cpuidle: using IS_ENABLED for multi SoCs management in
    init func
  ARM: tegra: check processor id in tegra_{set,clear}_cpu_in_lp2

 arch/arm/mach-tegra/common.c          |  2 ++
 arch/arm/mach-tegra/cpuidle-tegra20.c | 10 +++-------
 arch/arm/mach-tegra/cpuidle-tegra30.c | 10 +++-------
 arch/arm/mach-tegra/cpuidle.c         | 27 +++++++--------------------
 arch/arm/mach-tegra/cpuidle.h         | 15 +++------------
 arch/arm/mach-tegra/pm.c              | 19 +++++++++++++++----
 arch/arm/mach-tegra/pm.h              |  4 ++--
 7 files changed, 35 insertions(+), 52 deletions(-)

-- 
1.8.3
