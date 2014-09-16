From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Sep 2014 18:04:00 +0800
Subject: [PATCH v3 0/2] clk: sun8i: Add MBUS support
Message-ID: <1410861842-2743-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of my sun8i MBUS clock series.

This series depends on Maxime's "clk: sunxi: Improve MMC clocks support"
series, specifically the patches that change the factor clocks and move
out mod0 and mbus. Ideally this series should also be merged after my
"clk: sun6i: Unify AHB1 clock and fix rate calculation" for the PLL6
corrections, but I don't think it would cause any issues if it didn't.

Patch 1 adds the sun8i specific MBUS clock driver.

Patch 2 adds proper PLL6 and MBUS clock nodes to the DT, with a dummy
PLL5 clock node as a parent to MBUS.

Changes since v2:
  - Fixed multi-line comment style

Changes since v1:
  - Added commit message to patch 1
  - Moved sun8i-mbus clk to separate file


Cheers
ChenYu


Chen-Yu Tsai (2):
  clk: sunxi: Add sun8i MBUS clock support
  ARM: dts: sun8i: Add PLL6 and MBUS clock nodes

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun8i-a23.dtsi                  | 29 ++++++++-
 drivers/clk/sunxi/Makefile                        |  1 +
 drivers/clk/sunxi/clk-sun8i-mbus.c                | 78 +++++++++++++++++++++++
 4 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun8i-mbus.c

-- 
2.1.0
