From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Oct 2012 17:10:26 -0600
Subject: [GIT PULL] ARM: tegra: fixes for 3.7-rc2
Message-ID: <1350515426-31517-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a couple small fixes for Tegra for 3.7.

* A fix for another clock rate calculation overflow
* A revert of a change that removed the "timer" clock on Tegra, coupled
  with a fix for the confusing symbol name clash that triggered it.

----------------------------------------------------------------

BTW, I signed this tag with my swarren at nvidia.com key; it's a different key
to the one I used before, but has the same signatures and should show up on
all the same keyservers.

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-fixes-for-rc2

for you to fetch changes up to bf88ef883585ebc1a6c2369483833ed11ca7666c:

  ARM: tegra: add tegra_timer clock

----------------------------------------------------------------

Mark Zhang (1):
      ARM: tegra30: clk: Fix output_rate overflow

Sivaram Nair (2):
      ARM: tegra: rename tegra system timer
      ARM: tegra: add tegra_timer clock

 arch/arm/mach-tegra/board-dt-tegra20.c    |    2 +-
 arch/arm/mach-tegra/board-dt-tegra30.c    |    2 +-
 arch/arm/mach-tegra/board.h               |    2 +-
 arch/arm/mach-tegra/tegra20_clocks_data.c |    1 +
 arch/arm/mach-tegra/tegra30_clocks.c      |    2 +-
 arch/arm/mach-tegra/tegra30_clocks_data.c |    1 +
 arch/arm/mach-tegra/timer.c               |    2 +-
 7 files changed, 7 insertions(+), 5 deletions(-)
