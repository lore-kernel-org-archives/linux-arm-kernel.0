From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 18 Sep 2013 17:40:52 +0300
Subject: [PATCH 00/12] Introduce common infra for tegra clocks
Message-ID: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces common infrastructure for clocks which exist in
several Tegra SoCs. We also move Tegra114 to this new infrastructure.
Tegra20 and Tegra30 will be moved later in separate patchsets.

Peter De Schrijver (12):
  clk: tegra: simplify periph clock data
  clk: tegra: periph_clk_enb_refcnt as common infra
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
 drivers/clk/tegra/clk-tegra-periph.c     |  595 ++++++++++++
 drivers/clk/tegra/clk-tegra-pmc.c        |  131 +++
 drivers/clk/tegra/clk-tegra-super-gen4.c |  220 +++++
 drivers/clk/tegra/clk-tegra114.c         | 1547 +++++-------------------------
 drivers/clk/tegra/clk-tegra20.c          |   20 +-
 drivers/clk/tegra/clk-tegra30.c          |   23 +-
 drivers/clk/tegra/clk.c                  |  149 +++
 drivers/clk/tegra/clk.h                  |   48 +-
 15 files changed, 2080 insertions(+), 1364 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-id.h
 create mode 100644 drivers/clk/tegra/clk-tegra-audio.c
 create mode 100644 drivers/clk/tegra/clk-tegra-fixed.c
 create mode 100644 drivers/clk/tegra/clk-tegra-osc.c
 create mode 100644 drivers/clk/tegra/clk-tegra-periph.c
 create mode 100644 drivers/clk/tegra/clk-tegra-pmc.c
 create mode 100644 drivers/clk/tegra/clk-tegra-super-gen4.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
