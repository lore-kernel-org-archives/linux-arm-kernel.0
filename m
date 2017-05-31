From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 May 2017 15:58:18 +0800
Subject: [PATCH v2 0/6] clk: sunxi-ng: Add support for A83T's PRCM
Message-ID: <20170531075824.657-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is the remaining parts of my A83T PRCM support series, along with
changes requested by Maxime.

Patch 1 updates the device tree bindings for the PRCM, adding pll-periph
to the list of required clocks

Patch 2 adds a device node for the PRCM on the A83T SoC, updated from v1
to include the pll-periph clock.

Patch 3 exports the PLL_PERIPH0 clock from the CCU on the H3/H5, for
consumption by the PRCM.

Patch 4 adds the pll-periph clock to the PRCM device node on the H3/H5.

Patch 5 / 6 are the same as 3 / 4, but for the A64.


Excerpt from v1 cover letter:

This series adds support for the A83T's PRCM to the existing sun8i-r-ccu
driver. When the sun8i-r-ccu driver was introduced, indices were reserved
for all the possible clocks and resets of the sun8i family. In patch 2
we simply pick existing clocks, and implement ones that are different or
missing.

Differences from other sun8i implementations include different clock parent
names, due to the A83T not having a proper 32.768 kHz oscillator, and
different predividers for the IR clock.


Still to come are support for R_PIO and RSB on the A83T.

Regards
ChenYu


Chen-Yu Tsai (6):
  dt-bindings: clock: sunxi-ccu: Add pll-periph to PRCM's needed clocks
  ARM: sun8i: a83t: Add device node for PRCM
  clk: sunxi-ng: h3: Export PLL_PERIPH0 clock for the PRCM
  ARM: sunxi: h3-h5: Add PLL_PERIPH0 clock to the R_CCU
  clk: sunxi-ng: a64: Export PLL_PERIPH0 clock for the PRCM
  arm64: allwinner: a64: Add PLL_PERIPH0 clock to the R_CCU

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt |  7 ++++---
 arch/arm/boot/dts/sun8i-a83t.dtsi                     | 10 ++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                    |  5 +++--
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         |  5 +++--
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h                 |  4 +++-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                   |  4 +++-
 include/dt-bindings/clock/sun50i-a64-ccu.h            |  2 ++
 include/dt-bindings/clock/sun8i-h3-ccu.h              |  2 ++
 8 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.11.0
