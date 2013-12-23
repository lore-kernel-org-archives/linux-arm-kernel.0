From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 23 Dec 2013 00:32:31 -0300
Subject: [PATCH v3 00/13] clk: sunxi: add PLL5 and PLL6 support
Message-ID: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v3 of the sunxi clock series. For those seeing this for the 
first time, it adds PLL4, PLL5, PLL6 and mod0 clock support on sun4i, sun5i
and sun7i. Additionally, mbus is supported on sun5i and sun7i. I would like 
to see this merged for 3.14 as clock users are progressing rapidly and will
be needing this code, so all feedback is appreciated.

v2 -> v3 changelog:
* clean magic 5 on parent char arrays
* drop special consideration for pll5, as the clock protection function
  should be enough to keep that clock enabled.
* rework the mod0 and mbus nodes as suggested by Maxime, and add a bit 
  of code to keep the old nodes working.
* add Acked-by tags from Mike

Cheers,

Emilio

Emilio L?pez (13):
  clk: sunxi: register factors clocks behind composite
  clk: sunxi: clean the magic number of mux parents
  clk: sunxi: add gating support to PLL1
  ARM: sunxi: add PLL4 support
  clk: sunxi: make factors_clk_setup return the clock it registers
  clk: sunxi: add PLL5 and PLL6 support
  ARM: sunxi: add PLL5 and PLL6 support
  clk: sunxi: mod0 support
  clk: sunxi: support better factor DT nodes
  ARM: sun4i: dt: mod0 clocks
  ARM: sun5i: dt: mod0 clocks
  ARM: sun7i: dt: mod0 clocks
  ARM: sunxi: dt: add nodes for the mbus clock

 Documentation/devicetree/bindings/clock/sunxi.txt |   9 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                  | 146 ++++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                 | 122 ++++++-
 arch/arm/boot/dts/sun5i-a13.dtsi                  | 122 ++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 161 ++++++++-
 drivers/clk/sunxi/clk-factors.c                   |  63 +---
 drivers/clk/sunxi/clk-factors.h                   |  16 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 378 +++++++++++++++++++++-
 8 files changed, 921 insertions(+), 96 deletions(-)

-- 
1.8.5.2
