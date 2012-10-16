From: sivaramn@nvidia.com (Sivaram Nair)
Date: Tue, 16 Oct 2012 13:08:34 +0300
Subject: [PATCH 0/2] ARM: tegra: bring back tegra_timer clock
Message-ID: <1350382116-18024-1-git-send-email-sivaramn@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes a bug introduced by commit
20f4665831cec65d6e5d33587bba28ffa536b91d by bringing back the
tegra_timer clock.  The above commit caused tegra_init_timer() failing
to get the clk reference.

The first patch renames the existing tegra_timer object to
tegra_sys_timer and the second patch adds previously-removed tegra_timer
clock object.

Sivaram Nair (2):
  ARM: tegra: rename tegra system timer
  ARM: tegra: add tegra_timer clock

 arch/arm/mach-tegra/board-dt-tegra20.c    |    2 +-
 arch/arm/mach-tegra/board-dt-tegra30.c    |    2 +-
 arch/arm/mach-tegra/board.h               |    2 +-
 arch/arm/mach-tegra/tegra20_clocks_data.c |    1 +
 arch/arm/mach-tegra/tegra30_clocks_data.c |    1 +
 arch/arm/mach-tegra/timer.c               |    2 +-
 6 files changed, 6 insertions(+), 4 deletions(-)
