From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:06 -0700
Subject: [GIT PULL 04/10] ARM: tegra: dependency from the clock tree
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes the Tegra clock driver changes for 3.14, which are a
dependency for the Tegra DMA/reset common binding conversion.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>

----------------------------------------------------------------

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1

are available in the git repository at:

  git://nv-tegra.nvidia.com/user/pdeschrijver/linux clk-tegra-for-3.14

or:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git clk-tegra-for-3.14

The branch is also included in the following repo, but was pulled before
Peter set up a signed tag for it:

  git://git.linaro.org/people/mturquette/linux.git for-next

for you to fetch changes up to 62ce7cd62f534023224912dc9b909963f26a38da:

  clk: tegra: fix __clk_lookup() return value checks

----------------------------------------------------------------

Alexandre Courbot (1):
      clk: tegra: add FUSE clock device

Andrew Chew (1):
      clk: tegra: Set the clk parent of host1x to pll_p

Joseph Lo (2):
      clk: tegra124: add wait_for_reset and disable_clock for tegra_cpu_car_ops
      clk: tegra124: add suspend/resume function for tegra_cpu_car_ops

Mark Zhang (3):
      clk: tegra: Correct sbc mux width & parent
      clk: tegra: Fix vde/2d/3d clock src offset
      clk: tegra: Set the clock parent of gr2d/gr3d to pll_c2

Mikko Perttunen (1):
      clk: tegra114: Initialize clocks needed for HDMI

Peter De Schrijver (27):
      ARM: tegra114: add missing clocks to binding
      clk: tegra: replace enum tegra114_clk by binding header
      clk: tegra: add TEGRA_DIVIDER_ROUND_UP for periph clks
      clk: tegra: PLLE spread spectrum control
      ARM: tegra30: add missing CLK IDs
      clk: tegra: simplify periph clock data
      clk: tegra: common periph_clk_enb_refcnt and clks
      clk: tegra: Add TEGRA_PERIPH_NO_DIV flag
      clk: tegra: move some PLLC and PLLXC init to clk-pll.c
      clk: tegra: use pll_ref as the pll_e parent
      clk: tegra: move fields to tegra_clk_pll_params
      clk: tegra: add header for common tegra clock IDs
      clk: tegra: add common infra for DT clocks
      clk: tegra: add clkdev registration infra
      clk: tegra: move audio clk to common file
      clk: tegra: move periph clocks to common file
      clk: tegra: move PMC, fixed clocks to common files
      clk: tegra: introduce common gen4 super clock
      clk: tegra: move tegra30 to common infra
      clk: tegra: move tegra20 to common infra
      clk: tegra: Add support for PLLSS
      clk: tegra: Add periph regs bank X
      clk: tegra: add locking to periph clks
      clk: tegra: add TEGRA_PERIPH_NO_GATE
      clk: tegra124: Add common clk IDs to clk-id.h
      clk: tegra124: Add new peripheral clocks
      clk: tegra124: Add support for Tegra124 clocks

Thierry Reding (6):
      clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d
      clk: tegra: Fix clock rate computation
      clk: tegra: Initialize secondary gr3d clock on Tegra30
      clk: tegra: Properly setup PWM clock on Tegra30
      clk: tegra: Initialize DSI low-power clocks
      clk: tegra: Do not print errors for clk_round_rate()

Wei Yongjun (1):
      clk: tegra: fix __clk_lookup() return value checks

 .../bindings/clock/nvidia,tegra124-car.txt      |   59 +
 drivers/clk/tegra/Makefile                      |    7 +-
 drivers/clk/tegra/clk-id.h                      |  235 +++
 drivers/clk/tegra/clk-periph-gate.c             |    8 +-
 drivers/clk/tegra/clk-periph.c                  |   32 +-
 drivers/clk/tegra/clk-pll.c                     |  407 ++++-
 drivers/clk/tegra/clk-tegra-audio.c             |  215 +++
 drivers/clk/tegra/clk-tegra-fixed.c             |  111 ++
 drivers/clk/tegra/clk-tegra-periph.c            |  674 +++++++
 drivers/clk/tegra/clk-tegra-pmc.c               |  132 ++
 drivers/clk/tegra/clk-tegra-super-gen4.c        |  149 ++
 drivers/clk/tegra/clk-tegra114.c                | 1687 ++++--------------
 drivers/clk/tegra/clk-tegra124.c                | 1424 +++++++++++++++
 drivers/clk/tegra/clk-tegra20.c                 |  818 ++++-----
 drivers/clk/tegra/clk-tegra30.c                 | 1506 +++++-----------
 drivers/clk/tegra/clk.c                         |  166 ++
 drivers/clk/tegra/clk.h                         |  115 +-
 include/dt-bindings/clock/tegra114-car.h        |    8 +-
 include/dt-bindings/clock/tegra124-car.h        |  341 ++++
 include/dt-bindings/clock/tegra30-car.h         |   10 +-
 20 files changed, 5091 insertions(+), 3013 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
 create mode 100644 drivers/clk/tegra/clk-id.h
 create mode 100644 drivers/clk/tegra/clk-tegra-audio.c
 create mode 100644 drivers/clk/tegra/clk-tegra-fixed.c
 create mode 100644 drivers/clk/tegra/clk-tegra-periph.c
 create mode 100644 drivers/clk/tegra/clk-tegra-pmc.c
 create mode 100644 drivers/clk/tegra/clk-tegra-super-gen4.c
 create mode 100644 drivers/clk/tegra/clk-tegra124.c
 create mode 100644 include/dt-bindings/clock/tegra124-car.h
