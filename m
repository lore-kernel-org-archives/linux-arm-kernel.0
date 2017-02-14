From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Feb 2017 11:35:21 +0800
Subject: [PATCH 0/5] clk: sunxi-ng: Add support for A83T CCU
Message-ID: <20170214033526.16977-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is yet another series that adds support for the A83T CCU.
The A83T CCU has a mix of new styled (like the A80) clocks at
old (like A3x) offsets. Some differences include:

  - D1/D2 style PLL clocks
  - divisible audio module clocks
  - new timing mode for mmc2 module clock

Patch 1 fixes the mp style clock to take into account pre-dividers
for the .set_rate and .recalc_rate callbacks.

Patch 2 makes the gate clocks support common pre-dividers. This is
used to make the HSIC 12M clock have the right clock rate.

Patch 3 adds a compatible string for the A83T CCU to the sunxi-ccu
bindings.

Patch 4 adds the driver for the A83T CCU.

Patch 5 adds the CCU device nodes, and fixes up any existing clock
phandles in the dtsi.

Let me know what you think.


Regards
ChenYu


Chen-Yu Tsai (5):
  clk: sunxi-ng: mp: Adjust parent rate for pre-dividers
  clk: sunxi-ng: gate: Support common pre-dividers
  clk: sunxi-ng: Add compatible string for A83T CCU to bindings
  clk: sunxi-ng: Add driver for A83T CCU
  ARM: dts: sun8i-a83t: Add CCU device nodes

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  18 +-
 drivers/clk/sunxi-ng/Kconfig                       |  10 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              | 898 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.h              |  65 ++
 drivers/clk/sunxi-ng/ccu_gate.c                    |  47 ++
 drivers/clk/sunxi-ng/ccu_mp.c                      |   8 +
 include/dt-bindings/clock/sun8i-a83t-ccu.h         | 138 ++++
 include/dt-bindings/reset/sun8i-a83t-ccu.h         |  98 +++
 10 files changed, 1282 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.h
 create mode 100644 include/dt-bindings/clock/sun8i-a83t-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-a83t-ccu.h

-- 
2.11.0
