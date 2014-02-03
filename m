From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Feb 2014 09:51:36 +0800
Subject: [PATCH v4 0/8] ARM: sunxi: rename DT clock node names to clk@N
Message-ID: <1391392304-4660-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v4 of the clock node renaming patch series, which renames
the clock nodes in sunxi dts to conform to device tree naming
conventions, i.e. clk at N. Dummy clocks that will be renamed/removed
later, or clocks sharing registers are not renamed.

Renamed clock nodes have clock-output-names properties added to
desginate their names. Support for this is added in the first
patch.

Changes since v3:
  * Simplify device tree binding documentation: require all sunxi clocks
    to have clock-output-names.
  * Add clock-output-names to all sunxi clock nodes, including ones not
    renamed.

Changes since v2:

  * Dropped Cubietruck dts i2c controller patch. Maxime has taken it.
  * Changed ARM in commit messages to uppercase.
  * Add pll5, pll6 clock names to factors_data tied to compatible strings.
  * Dropped pll5 output name in dts due to the previous change.
  * Added dts binding documentation for "clock-output-names", as well as
    examples.

Changes since v1:

  * Fixed pll5, pll6 divs clock name handling 

Cheers
ChenYu

Chen-Yu Tsai (8):
  clk: sunxi: add clock-output-names dt property support
  clk: sunxi: update clock-output-names dt binding documentation
  clk: sunxi: add names for pll5, pll6 parent clocks to factors_data
  clk: sunxi: get divs parent clock name from parent factor clock
  ARM: dts: sun4i: rename clock node names to clk at N
  ARM: dts: sun5i: rename clock node names to clk at N
  ARM: dts: sun6i: rename clock node names to clk at N
  ARM: dts: sun7i: rename clock node names to clk at N

 Documentation/devicetree/bindings/clock/sunxi.txt | 32 ++++++++++++++++----
 arch/arm/boot/dts/sun4i-a10.dtsi                  | 30 ++++++++++++-------
 arch/arm/boot/dts/sun5i-a10s.dtsi                 | 30 ++++++++++++-------
 arch/arm/boot/dts/sun5i-a13.dtsi                  | 30 ++++++++++++-------
 arch/arm/boot/dts/sun6i-a31.dtsi                  | 19 ++++++++----
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 25 +++++++++++-----
 drivers/clk/sunxi/clk-sunxi.c                     | 36 ++++++++++++++++-------
 7 files changed, 143 insertions(+), 59 deletions(-)

-- 
1.9.rc1
