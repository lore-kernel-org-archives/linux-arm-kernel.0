From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 17 Dec 2013 21:44:52 -0300
Subject: [PATCH v2 00/11] clk: sunxi: PLL4/5/6, mod0 and mbus support
Message-ID: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a v2 of the sunxi clock series I posted some time ago. It adds 
PLL4, PLL5, PLL6 and mod0 support on sun4i, sun5i and sun7i. Additionally,
mbus is supported on sun5i and sun7i. I would like to see this merged 
for 3.14 as clock users are progressing rapidly and will be needing this 
code, so all feedback is appreciated.

It's been some time since I worked on this series, so I cannot make a 
detailed changelog, but in general, I addressed the comments made by 
Maxime on the previous iteration, and reworked the PLL5/6 clk patch to 
fix an issue with a gate that the people working on the SATA driver made 
me aware of.

Cheers,

Emilio

Emilio L?pez (11):
  clk: sunxi: register factors clocks behind composite
  clk: sunxi: add gating support to PLL1
  ARM: sunxi: add PLL4 support
  clk: sunxi: make factors_clk_setup return the clock it registers
  clk: sunxi: add PLL5 and PLL6 support
  ARM: sunxi: add PLL5 and PLL6 support
  clk: sunxi: mod0 support
  ARM: sun4i: dt: mod0 clocks
  ARM: sun5i: dt: mod0 clocks
  ARM: sun7i: dt: mod0 clocks
  ARM: sunxi: dt: add nodes for the mbus clock

 Documentation/devicetree/bindings/clock/sunxi.txt |   9 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                  | 131 +++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                 | 110 ++++++-
 arch/arm/boot/dts/sun5i-a13.dtsi                  | 110 ++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 145 ++++++++-
 drivers/clk/sunxi/clk-factors.c                   |  63 +---
 drivers/clk/sunxi/clk-factors.h                   |  16 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 364 +++++++++++++++++++++-
 8 files changed, 854 insertions(+), 94 deletions(-)

-- 
1.8.5.1
