From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Sep 2014 00:48:04 +0800
Subject: [PATCH 0/2] clk: sun8i: Add MBUS support
Message-ID: <1410540486-22243-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for the MBUS clock on sun8i. It is slightly
different from the old mod0 clocks in that the divider is 3 bits wider,
while also needing a divider table.

This series depends on Maxime's "clk: sunxi: Improve MMC clocks support"
series, specifically the patches that change the factor clocks and move
out mod0 and mbus. Ideally this series should also be merged after my
"clk: sun6i: Unify AHB1 clock and fix rate calculation" for the PLL6
corrections, but I don't think it would cause any issues if it didn't.

Patch 1 adds the sun8i specific MBUS clock driver.

Patch 2 adds proper PLL6 and MBUS clock nodes to the DT, with a dummy
PLL5 clock node as a parent to MBUS.


Cheers
ChenYu


Chen-Yu Tsai (2):
  clk: sunxi: Add sun8i MBUS clock support
  ARM: dts: sun8i: Add PLL6 and MBUS clock nodes

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun8i-a23.dtsi                  | 29 +++++++++++-
 drivers/clk/sunxi/clk-mod0.c                      | 55 +++++++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.1.0
