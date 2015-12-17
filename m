From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Dec 2015 13:50:35 +0100
Subject: [GIT PULL 1/5] clk: tegra: Changes for v4.5-rc1
Message-ID: <1450356639-7758-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.5-clk

for you to fetch changes up to 2d7f61f37731f635af47615a8a331ffe7f884934:

  clk: tegra: Read correct IDDQ register in PLL_SS registration (2015-12-17 13:37:58 +0100)

Note that the first commit in this set adds the device tree bindings for
Tegra210. This is a dependency for the for-4.5/dt branch because it adds
the dt-bindings include file used by the Tegra210 DTS files.

Thanks,
Thierry

----------------------------------------------------------------
clk: tegra: Changes for v4.5-rc1

This set of changes adds support for the Tegra210 SoC and contains a
couple fixes and cleanups.

----------------------------------------------------------------
Andrew Bresticker (1):
      clk: tegra: pll: Fix issues with rates for VCO PLLs

Bill Huang (8):
      clk: tegra: pll: Change misc_reg count from 3 to 6
      clk: tegra: pll: Add code to handle if resets are supported by PLL
      clk: tegra: pll: Adjust vco_min if SDM present
      clk: tegra: pll: Add Set_default logic
      clk: tegra: pll: Add logic for SS
      clk: tegra: Add Super Gen5 Logic
      clk: tegra: Fix WARN_ON in PLL_RE registration
      clk: tegra: Read correct IDDQ register in PLL_SS registration

Danny Huang (1):
      clk: tegra: pll: Update PLLM handling

Rhyland Klein (12):
      clk: tegra: periph: Add new periph clks and muxes for Tegra210
      clk: tegra: pll: Add tegra_pll_wait_for_lock to clk header
      clk: tegra: pll: Simplify clk_enable_path
      clk: tegra: pll: Update warning message
      clk: tegra: pll: Don't unconditionally set LOCK flags
      clk: tegra: pll: Add logic for handling SDM data
      clk: tegra: pll: Add logic for out-of-table rates for T210
      clk: tegra: pll: Fix _pll_ramp_calc_pll logic and _calc_dynamic_ramp_rate
      clk: tegra: pll: Add specialized logic for Tegra210
      clk: tegra: pll: Add support for PLLMB for Tegra210
      clk: tegra: pll: Add dyn_ramp callback
      clk: tegra: Add support for Tegra210 clocks

Thierry Reding (5):
      clk: tegra: Add Tegra210 device tree binding
      clk: tegra: Fix 26 MHz oscillator frequency
      clk: tegra: Miscellaneous coding style cleanups
      clk: tegra: Format tables consistently
      clk: tegra: Constify pdiv-to-hw mappings

 .../bindings/clock/nvidia,tegra210-car.txt         |   56 +
 drivers/clk/tegra/Makefile                         |    1 +
 drivers/clk/tegra/clk-id.h                         |   75 +-
 drivers/clk/tegra/clk-pll.c                        |  838 ++++--
 drivers/clk/tegra/clk-tegra-periph.c               |  371 ++-
 drivers/clk/tegra/clk-tegra-super-gen4.c           |  142 +-
 drivers/clk/tegra/clk-tegra114.c                   |  339 +--
 drivers/clk/tegra/clk-tegra124.c                   |  453 ++--
 drivers/clk/tegra/clk-tegra20.c                    |  314 ++-
 drivers/clk/tegra/clk-tegra210.c                   | 2852 ++++++++++++++++++++
 drivers/clk/tegra/clk-tegra30.c                    |  426 +--
 drivers/clk/tegra/clk.h                            |  101 +-
 include/dt-bindings/clock/tegra210-car.h           |  401 +++
 13 files changed, 5439 insertions(+), 930 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra210-car.txt
 create mode 100644 drivers/clk/tegra/clk-tegra210.c
 create mode 100644 include/dt-bindings/clock/tegra210-car.h
