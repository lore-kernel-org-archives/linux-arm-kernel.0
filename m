From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Sep 2014 00:30:23 +0200
Subject: [PATCH v2 0/7] ARM: Rockchip: add cpuclk handling - clock-tree part
Message-ID: <1410561030-19127-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements cpu frequency-scaling for Rockchip SoCs.
The whole handling of the armclk frequency changes and therefore
the implementention is very similar to the recent series for
Samsung SoCs from Thomas Abraham.

Tested on a
- rk3066 Marsboard
- rk3188 Radxa Rock
- rk3288 Evaluation board

This is the part that would go through the clock tree and the patches
are build against current clk-next.

On the arm-soc side we would need the ARMCLK id in an exported branch
from the clk tree so that the devicetree changes can use this new id.

The series also is split, as clk-next and the arm-soc parts have diverged
so much, that it's not possible to create one series against one tree
and stay sane.

changes since v1:
- address comments received concerning smaller issues
- split series into two, one for clk-next and one for arm-soc

Heiko Stuebner (6):
  clk: rockchip: fix rk3066 pll status register location
  clk: rockchip: reparent aclk_cpu_pre to the gpll
  clk: rockchip: make tightly bound armclk child-clocks read-only
  clk: rockchip: add new clock-type for the cpuclk
  clk: rockchip: add binding id for ARMCLK
  clk: rockchip: switch to using the new cpuclk type for armclk

Jianqun (1):
  clk: rockchip: fix rk3288 pll status register location

 drivers/clk/rockchip/Makefile                 |   1 +
 drivers/clk/rockchip/clk-cpu.c                | 316 ++++++++++++++++++++++++++
 drivers/clk/rockchip/clk-rk3188.c             | 161 +++++++++++--
 drivers/clk/rockchip/clk-rk3288.c             |  93 ++++++--
 drivers/clk/rockchip/clk.c                    |  20 ++
 drivers/clk/rockchip/clk.h                    |  36 +++
 include/dt-bindings/clock/rk3188-cru-common.h |   1 +
 include/dt-bindings/clock/rk3288-cru.h        |   1 +
 8 files changed, 601 insertions(+), 28 deletions(-)
 create mode 100644 drivers/clk/rockchip/clk-cpu.c

-- 
2.0.1
