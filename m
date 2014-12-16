From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Dec 2014 12:38:24 -0800
Subject: [PATCH 0/4] clk: tegra: add support for the Tegra132 CAR IP block
Message-ID: <20141216203813.22980.2301.stgit@chromeos-P9X79>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series follows up on Peter De Schrijver's posting of a Tegra132
CAR series in July of this year.  It adds common clock framework
support for the Tegra132 CAR IP block.

The patches are based on next-20141209 and have been compiled and
boot-tested on a Tegra30 Beaver board, a Tegra114 Dalmore board, and a
Tegra124 Jetson TK1.  They've also been tested on a Tegra132 Norrin
FFD board, with some other patches applied since support for that
board isn't completely upstream (but is coming shortly).

Intended for v3.20.

- Paul

---

Paul Walmsley (2):
      clk: tegra:  split Tegra124 clock header file
      clk: tegra: Add support for the Tegra132 CAR IP block

Peter De Schrijver (2):
      clk: tegra: make tegra_clocks_apply_init_table() arch_initcall
      clk: tegra: Update binding doc for Tegra132


 .../bindings/clock/nvidia,tegra124-car.txt         |   10 -
 arch/arm/mach-tegra/tegra.c                        |    2 
 drivers/clk/tegra/Makefile                         |    1 
 drivers/clk/tegra/clk-pll.c                        |   10 -
 drivers/clk/tegra/clk-tegra124.c                   |  130 +++++++-
 drivers/clk/tegra/clk.c                            |    7 
 include/dt-bindings/clock/tegra124-car-common.h    |  345 ++++++++++++++++++++
 include/dt-bindings/clock/tegra124-car.h           |  345 +-------------------
 include/linux/clk/tegra.h                          |    2 
 9 files changed, 494 insertions(+), 358 deletions(-)
 create mode 100644 include/dt-bindings/clock/tegra124-car-common.h
