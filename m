From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 17:59:56 +0200
Subject: [GIT PULL] clk: tegra: Changes for v4.7-rc1
Message-ID: <1461945596-24090-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael, Stephen,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-clk

for you to fetch changes up to 2690e912644e610854c4c3b23d0a0daec9d030ca:

  clk: tegra: dfll: Reformat CVB frequency table (2016-04-28 12:41:54 +0200)

Note that the first patch is this pull request is a dependency for a
larger series that will have to go in through the ARM-SoC tree in order
to properly handle the dependencies.

Thanks,
Thierry

----------------------------------------------------------------
clk: tegra: Changes for v4.7-rc1

This set of changes contains a bunch of cleanups and minor fixes along
with some new clocks, mainly on Tegra210, in preparation for supporting
DisplayPort and HDMI 2.0.

----------------------------------------------------------------
Andrew Bresticker (1):
      clk: tegra: Add interface to enable hardware control of SATA/XUSB PLLs

Lucas Stach (2):
      clk: tegra: Initialize PLL_C to sane rate on Tegra30
      clk: tegra: Fix PLL_U post divider and initial rate on Tegra30

Rhyland Klein (1):
      clk: tegra: Fix pllre Tegra210 and add pll_re_out1

Thierry Reding (13):
      clk: tegra: Constify peripheral clock registers
      clk: tegra: Remove trailing blank line
      clk: tegra: Special-case mipi-cal parent on Tegra114
      clk: tegra: Add fixed factor peripheral clock type
      clk: tegra: Use correct parent for dpaux clock
      clk: tegra: Add dpaux1 clock
      clk: tegra: dpaux and dpaux1 are fixed factor clocks
      clk: tegra: Add sor_safe clock
      clk: tegra: dfll: Update kerneldoc
      clk: tegra: dfll: Reference CVB table instead of copying data
      clk: tegra: dfll: Make code more comprehensible
      clk: tegra: dfll: Properly clean up on failure and removal
      clk: tegra: dfll: Reformat CVB frequency table

 drivers/clk/tegra/Makefile                 |   1 +
 drivers/clk/tegra/clk-dfll.c               |  11 +--
 drivers/clk/tegra/clk-dfll.h               |  22 +++---
 drivers/clk/tegra/clk-id.h                 |   2 +
 drivers/clk/tegra/clk-periph-fixed.c       | 120 +++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-periph-gate.c        |   2 +-
 drivers/clk/tegra/clk-periph.c             |   2 +-
 drivers/clk/tegra/clk-pll.c                |  46 +++++++++++
 drivers/clk/tegra/clk-tegra-fixed.c        |   1 -
 drivers/clk/tegra/clk-tegra-periph.c       |   5 +-
 drivers/clk/tegra/clk-tegra114.c           |   6 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 103 ++++++++++++++-----------
 drivers/clk/tegra/clk-tegra124.c           |   4 +
 drivers/clk/tegra/clk-tegra210.c           |  87 ++++++++++++++++++++-
 drivers/clk/tegra/clk-tegra30.c            |  12 +--
 drivers/clk/tegra/clk.c                    |   4 +-
 drivers/clk/tegra/clk.h                    |  27 ++++++-
 drivers/clk/tegra/cvb.c                    |  71 ++++++++++-------
 drivers/clk/tegra/cvb.h                    |  15 ++--
 include/dt-bindings/clock/tegra210-car.h   |   2 +-
 include/linux/clk/tegra.h                  |   5 ++
 21 files changed, 433 insertions(+), 115 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-periph-fixed.c
