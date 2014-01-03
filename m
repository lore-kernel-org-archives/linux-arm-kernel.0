From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  3 Jan 2014 16:01:45 +0800
Subject: [PATCH 0/6] arm: sunxi: rename DT clock node names to clk@N
Message-ID: <1388736111-10103-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch series renames the clock nodes in sunxi dts to conform
to device tree naming conventions, i.e. clk at N. Dummy clocks that
will be renamed/removed later, or clocks sharing registers are not
renamed.

Renamed clock nodes have clock-output-names properties added to
desginate their names. Support for this is added in the first
patch.

The last patch, which enables i2c controllers on Cubietruck, is
independent of the others.


Cheers
ChenYu


Chen-Yu Tsai (6):
  clk: sunxi: Add clock-output-names dt property support
  arm: dts: sun4i: rename clock node names to clk at N
  arm: dts: sun5i: rename clock node names to clk at N
  arm: dts: sun6i: rename clock node names to clk at N
  arm: dts: sun7i: rename clock node names to clk at N
  arm: sun7i: cubietruck: Enable the i2c controllers

 arch/arm/boot/dts/sun4i-a10.dtsi           | 24 ++++++++++++++----------
 arch/arm/boot/dts/sun5i-a10s.dtsi          | 24 ++++++++++++++----------
 arch/arm/boot/dts/sun5i-a13.dtsi           | 24 ++++++++++++++----------
 arch/arm/boot/dts/sun6i-a31.dtsi           | 12 +++++++-----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi           | 19 +++++++++++--------
 drivers/clk/sunxi/clk-sunxi.c              | 15 +++++++--------
 7 files changed, 85 insertions(+), 51 deletions(-)

-- 
1.8.5.2
