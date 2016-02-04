From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  4 Feb 2016 18:52:42 +0100
Subject: [GIT PULL] clk: tegra: Fixes for v4.5-rc3
Message-ID: <1454608362-8954-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Hi Mike, Stephen,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.5-clk-fixes

for you to fetch changes up to 5a1d5eff3ede4de4482015a9999336051054283f:

  clk: tegra: super: Fix sparse warnings for functions not declared as static (2016-02-02 15:49:34 +0100)

Thanks,
Thierry

----------------------------------------------------------------
clk: tegra: Fixes for v4.5-rc3

This set contains a bunch of miscellaneous fixes that have accumulated
over the past couple of weeks, primarily for the Tegra210 support added
in v4.5-rc1.

----------------------------------------------------------------
Amitoj Kaur Chawla (1):
      clk: tegra: Add missing of_node_put()

Andrew Bresticker (1):
      clk: tegra: pll: Fix potential sleeping-while-atomic

Jon Hunter (7):
      clk: tegra: Add the APB2APE audio clock on Tegra210
      clk: tegra: Fix clock sources for Tegra210 EMC
      clk: tegra: Fix warning caused by pll_u failing to lock
      clk: tegra: Use definition for pll_u override bit
      clk: tegra: Fix sparse warning for pll_m
      clk: tegra: Fix sparse warnings for functions not declared as static
      clk: tegra: super: Fix sparse warnings for functions not declared as static

Mark Kuo (2):
      clk: tegra: Do not disable PLLE when under hardware control
      clk: tegra: Fix PLLE SS coefficients

Rhyland Klein (6):
      clk: tegra: Fix divider on VI_I2C
      clk: tegra: Remove improper flags for lock_enable
      clk: tegra: Fix naming of MISC registers
      clk: tegra: Fix the misnaming of nvenc from msenc
      clk: tegra: Fix pllx dyn step calculation
      clk: tegra: Fix typos around clearing PLLE bits during enable

 drivers/clk/tegra/clk-emc.c              |   6 +-
 drivers/clk/tegra/clk-id.h               |   1 +
 drivers/clk/tegra/clk-pll.c              |  50 +++++++-----
 drivers/clk/tegra/clk-tegra-periph.c     |   5 +-
 drivers/clk/tegra/clk-tegra-super-gen4.c |   6 +-
 drivers/clk/tegra/clk-tegra210.c         | 132 ++++++++++++++-----------------
 include/dt-bindings/clock/tegra210-car.h |   2 +-
 7 files changed, 104 insertions(+), 98 deletions(-)
