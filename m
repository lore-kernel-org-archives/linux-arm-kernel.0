From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 23 Sep 2013 17:24:52 +0300
Subject: [PATCH v2 00/12] Introduce common infra for tegra clocks
Message-ID: <1379946381-20125-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces common infrastructure for clocks which exist in
several Tegra SoCs. We also move Tegra114 to this new infrastructure.
Tegra20 and Tegra30 will be moved later in separate patchsets.

Changes since v1:
+ move common clks allocation to patch 2
+ adapt also Tegra20 and Tegra30 to the changes in patch 2

Boottested on dalmore, beaverboard and seaboard.

Peter De Schrijver (12):
  clk: tegra: simplify periph clock data
  clk: tegra: common periph_clk_enb_refcnt and clks
  clk: tegra: Add TEGRA_PERIPH_NO_DIV flag
  clk: tegra: move some PLLC and PLLXC init to clk-pll.c
  clk: tegra: add header for common tegra clock IDs
  clk: tegra: add common infra for DT clocks
  clk: tegra: move audio clk to common file
  clk: tegra: move periph clocks to common file
  clk: tegra: move PMC clocks to common file
  clk: tegra: move fixed clocks to common file
  clk: tegra: introduce common tegra_osc_clk_init
  clk: tegra: introduce common gen4 super clock

 drivers/clk/tegra/Makefile               |    7 +-
 drivers/clk/tegra/clk-id.h               |  197 ++++
 drivers/clk/tegra/clk-periph.c           |    9 +-
 drivers/clk/tegra/clk-pll.c              |   95 ++-
 drivers/clk/tegra/clk-tegra-audio.c      |  260 +++++
 drivers/clk/tegra/clk-tegra-fixed.c      |   62 ++
 drivers/clk/tegra/clk-tegra-osc.c        |   81 ++
 drivers/clk/tegra/clk-tegra-periph.c     |  596 ++++++++++++
 drivers/clk/tegra/clk-tegra-pmc.c        |  131 +++
 drivers/clk/tegra/clk-tegra-super-gen4.c |  220 +++++
 drivers/clk/tegra/clk-tegra114.c         | 1547 +++++-------------------------
 drivers/clk/tegra/clk-tegra20.c          |   43 +-
 drivers/clk/tegra/clk-tegra30.c          |   47 +-
 drivers/clk/tegra/clk.c                  |  149 +++
 drivers/clk/tegra/clk.h                  |   48 +-
 15 files changed, 2095 insertions(+), 1397 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-id.h
 create mode 100644 drivers/clk/tegra/clk-tegra-audio.c
 create mode 100644 drivers/clk/tegra/clk-tegra-fixed.c
 create mode 100644 drivers/clk/tegra/clk-tegra-osc.c
 create mode 100644 drivers/clk/tegra/clk-tegra-periph.c
 create mode 100644 drivers/clk/tegra/clk-tegra-pmc.c
 create mode 100644 drivers/clk/tegra/clk-tegra-super-gen4.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
