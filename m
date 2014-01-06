From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  6 Jan 2014 13:58:04 +0800
Subject: [PATCH v2 0/8] arm: sunxi: rename DT clock node names to clk@N
Message-ID: <1388987892-23733-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of the clock node renaming patch series, which renames
the clock nodes in sunxi dts to conform to device tree naming
conventions, i.e. clk at N. Dummy clocks that will be renamed/removed
later, or clocks sharing registers are not renamed.

Renamed clock nodes have clock-output-names properties added to
desginate their names. Support for this is added in the first
patch.

The last patch, which enables i2c controllers on Cubietruck, is
not related to the clocks. Just submitting them together.

Changes since v1:

  * Fixed pll5, pll6 divs clock name handling 

Cheers
ChenYu


Chen-Yu Tsai (8):
  clk: sunxi: add clock-output-names dt property support
  clk: sunxi: choose correct name for multiple output factor clocks
  clk: sunxi: get divs parent clock name from parent factor clock
  arm: dts: sun4i: rename clock node names to clk at N
  arm: dts: sun5i: rename clock node names to clk at N
  arm: dts: sun6i: rename clock node names to clk at N
  arm: dts: sun7i: rename clock node names to clk at N
  arm: sun7i: cubietruck: Enable the i2c controllers

 arch/arm/boot/dts/sun4i-a10.dtsi           | 26 +++++++++++++++-----------
 arch/arm/boot/dts/sun5i-a10s.dtsi          | 26 +++++++++++++++-----------
 arch/arm/boot/dts/sun5i-a13.dtsi           | 26 +++++++++++++++-----------
 arch/arm/boot/dts/sun6i-a31.dtsi           | 12 +++++++-----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi           | 21 ++++++++++++---------
 drivers/clk/sunxi/clk-sunxi.c              | 27 +++++++++++++++++----------
 7 files changed, 99 insertions(+), 57 deletions(-)

-- 
1.8.5.2
