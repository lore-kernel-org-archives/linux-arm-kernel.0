From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Oct 2013 17:52:45 +0300
Subject: [PATCH v3 00/19] Introduce common infra for tegra clocks
Message-ID: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces common infrastructure for clocks which exist in                                                                                       
several Tegra SoCs. We also also move Tegra20, Tegra30 and Tegra114 to
this new infrastructure.

Changes since v1:                                                                                                                                              
+ move common clks allocation to patch 2                                                                                                                       
+ adapt also Tegra20 and Tegra30 to the changes in patch 2                                                                                                     
                                                                                                                                                               
Changes since v2:
+ move Tegra20 and Tegra30 to the common infrastructure
+ bug fixes and comments
+ merge clk-tegra-osc.c and clk-tegra-fixed.c in 1 file

Boottested on dalmore, beaverboard and seaboard.                                                                                                               

--

based on:

git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-patches-0

Peter De Schrijver (19):
  ARM: tegra30: add missing CLK IDs
  clk: tegra: simplify periph clock data
  clk: tegra: common periph_clk_enb_refcnt and clks
  clk: tegra: Add TEGRA_PERIPH_NO_DIV flag
  clk: tegra: move some PLLC and PLLXC init to clk-pll.c
  clk: tegra: move fields to tegra_clk_pll_params
  clk: tegra: add header for common tegra clock IDs
  clk: tegra: add common infra for DT clocks
  clk: tegra: add clkdev registration infra
  clk: tegra: move audio clk to common file
  clk: tegra: move periph clocks to common file
  clk: tegra: move PMC, fixed clocks to common files
  clk: tegra: introduce common gen4 super clock
  clk: tegra30: replace enum by binding header
  clk: tegra20: replace enum by binding header
  clk: tegra20: move tegra20 to common clkdev
  clk: tegra30: move tegra30 to common clkdev
  clk: tegra20: move to common periph clk
  clk: tegra30: move to common tegra clk infra

 drivers/clk/tegra/Makefile               |    6 +-
 drivers/clk/tegra/clk-id.h               |  213 ++++
 drivers/clk/tegra/clk-periph-gate.c      |    8 +-
 drivers/clk/tegra/clk-periph.c           |   15 +-
 drivers/clk/tegra/clk-pll.c              |  233 +++--
 drivers/clk/tegra/clk-tegra-audio.c      |  213 ++++
 drivers/clk/tegra/clk-tegra-fixed.c      |  113 +++
 drivers/clk/tegra/clk-tegra-periph.c     |  590 +++++++++++
 drivers/clk/tegra/clk-tegra-pmc.c        |  131 +++
 drivers/clk/tegra/clk-tegra-super-gen4.c |  151 +++
 drivers/clk/tegra/clk-tegra114.c         | 1601 ++++++------------------------
 drivers/clk/tegra/clk-tegra20.c          |  809 ++++++----------
 drivers/clk/tegra/clk-tegra30.c          | 1492 +++++++++-------------------
 drivers/clk/tegra/clk.c                  |  158 +++
 drivers/clk/tegra/clk.h                  |  101 ++-
 include/dt-bindings/clock/tegra30-car.h  |   10 +-
 16 files changed, 2902 insertions(+), 2942 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-id.h
 create mode 100644 drivers/clk/tegra/clk-tegra-audio.c
 create mode 100644 drivers/clk/tegra/clk-tegra-fixed.c
 create mode 100644 drivers/clk/tegra/clk-tegra-periph.c
 create mode 100644 drivers/clk/tegra/clk-tegra-pmc.c
 create mode 100644 drivers/clk/tegra/clk-tegra-super-gen4.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
