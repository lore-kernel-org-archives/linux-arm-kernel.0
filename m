From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Jun 2015 18:22:14 +0200
Subject: [PATCH 0/8] clk: rockchip: add support for the clock-tree of the
 rk3368
Message-ID: <1434212542-17145-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the clock controller of rk3368
ARM64 socs.

The first 2 patches are fixes for small issues I found while
building the clocktree. Both do not harm the functionality
of the older socs, as there is no camera interface driver in
them anyway and the issue with the defines only surfaced on
the rk3368.

Patch 3 then adds a new definition for a branch-type.

Some clocks (mainly the hsadc and camera interfaces) have a phase
inverter connected to the clock that makes it possible to adjust
the clock phase by 180 degrees. Patches 4 and 5 finally add
support for these inverters and add the currently missing
definitions to the already present clock drivers.

Patches 6, 7 and 8 finally add the shared dt-binding header and
the rk3368 clock tree itself. The cpu-clocks in there where
tested sucessfully with the big_little_cpufreq driver.


Heiko Stuebner (8):
  clk: rockchip: protect register macros against multipart values
  clk: rockchip: fix faulty vip parent name on rk3288
  clk: rockchip: add COMPOSITE_NOGATE_DIVTBL variant
  clk: rockchip: add support for phase inverters
  clk: rockchip: define the inverters of rk3066/rk3188 and rk3288
  dt-bindings: add documentation of rk3668 clock controller
  clk: rockchip: add dt-binding header for rk3368
  clk: rockchip: add rk3368 clock controller

 .../bindings/clock/rockchip,rk3368-cru.txt         |  61 ++
 drivers/clk/rockchip/Makefile                      |   2 +
 drivers/clk/rockchip/clk-inverter.c                | 126 +++
 drivers/clk/rockchip/clk-rk3188.c                  |   9 +-
 drivers/clk/rockchip/clk-rk3288.c                  |  11 +-
 drivers/clk/rockchip/clk-rk3368.c                  | 881 +++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   7 +
 drivers/clk/rockchip/clk.h                         |  72 +-
 include/dt-bindings/clock/rk3368-cru.h             | 379 +++++++++
 9 files changed, 1536 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-inverter.c
 create mode 100644 drivers/clk/rockchip/clk-rk3368.c
 create mode 100644 include/dt-bindings/clock/rk3368-cru.h

-- 
2.1.4
