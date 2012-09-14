From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 14:06:15 -0600
Subject: [GIT PULL 04/10] ARM: tegra: switch to the common clock framework
In-Reply-To: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347653181-19936-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a few bug-fixes, followed by a conversion of Tegra's
clock driver to the common clock framework, followed by various bug fixes
found after the conversion.

This branch depends on v3.6-rc4.

This branch is a dependency for a few later pull requests.

----------------------------------------------------------------

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-common-clk

for you to fetch changes up to b4350f40f73b75efdceae3d9e04266979acabd8c:

  ARM: Tegra: Add smp_twd clock for Tegra20

----------------------------------------------------------------

Joseph Lo (2):
      ARM: tegra: clocks: separate tegra_clk_32k_ops from Tegra20 and Tegra30
      ARM: tegra30: clocks: fix the wrong tegra_audio_sync_clk_ops name

Prashant Gaikwad (8):
      ARM: tegra30: Separate out clk ops and clk data
      ARM: tegra20: Separate out clk ops and clk data
      ARM: tegra: Rename tegra20 clock file
      ARM: tegra: Add clk_tegra structure and helper functions
      ARM: tegra: Port tegra to generic clock framework
      ARM: tegra: Remove duplicate code
      ARM: tegra: Fix data type for io address
      ARM: Tegra: Add smp_twd clock for Tegra20

Stephen Warren (5):
      ARM: tegra: turn on UART A clock at boot
      ARM: tegra: fix U16 divider range check
      ARM: tegra: remove tegra_timer from tegra_list_clks
      ARM: tegra: fix overflow in tegra20_pll_clk_round_rate()
      ARM: tegra: cpu-tegra: explicitly manage re-parenting

 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-tegra/Makefile              |    4 +-
 arch/arm/mach-tegra/board-dt-tegra20.c    |    1 +
 arch/arm/mach-tegra/clock.c               |  570 +-----
 arch/arm/mach-tegra/clock.h               |   40 +-
 arch/arm/mach-tegra/common.c              |    1 -
 arch/arm/mach-tegra/cpu-tegra.c           |   48 +-
 arch/arm/mach-tegra/include/mach/clk.h    |    3 +
 arch/arm/mach-tegra/tegra20_clocks.c      | 1555 +++++++++++++++
 arch/arm/mach-tegra/tegra20_clocks.h      |   42 +
 arch/arm/mach-tegra/tegra20_clocks_data.c | 1142 +++++++++++
 arch/arm/mach-tegra/tegra2_clocks.c       | 2484 ------------------------
 arch/arm/mach-tegra/tegra30_clocks.c      | 2475 ++++++++----------------
 arch/arm/mach-tegra/tegra30_clocks.h      |   53 +
 arch/arm/mach-tegra/tegra30_clocks_data.c | 1369 +++++++++++++
 15 files changed, 5055 insertions(+), 4733 deletions(-)
 create mode 100644 arch/arm/mach-tegra/tegra20_clocks.c
 create mode 100644 arch/arm/mach-tegra/tegra20_clocks.h
 create mode 100644 arch/arm/mach-tegra/tegra20_clocks_data.c
 delete mode 100644 arch/arm/mach-tegra/tegra2_clocks.c
 create mode 100644 arch/arm/mach-tegra/tegra30_clocks.h
 create mode 100644 arch/arm/mach-tegra/tegra30_clocks_data.c
