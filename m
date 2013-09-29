From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 29 Sep 2013 00:49:29 -0300
Subject: [PATCH 00/10] clk: sunxi: PLL4/5/6, mod0 and mbus support
Message-ID: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a followup series to my RFC series from some time ago. It adds 
PLL4, PLL5, PLL6 and mod0 support on sun4i, sun5i and sun7i. Additionally,
mbus is supported on sun5i and sun7i. I would like to see this merged for
3.13, so all feedback is welcome :)

Cheers,

Emilio

Emilio L?pez (10):
  clk: sunxi: register factors clocks behind composite
  clk: sunxi: add gating support to PLL1
  ARM: sunxi: add PLL4 support
  clk: sunxi: add PLL5 and PLL6 support
  ARM: sunxi: add PLL5 and PLL6 support
  clk: sunxi: mod0 support
  ARM: sun4i: dt: mod0 clocks
  ARM: sun5i: dt: mod0 clocks
  ARM: sun7i: dt: mod0 clocks
  ARM: sunxi: dt: add nodes for the mbus clock

 Documentation/devicetree/bindings/clock/sunxi.txt |   5 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                  | 131 +++++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                 | 110 +++++++-
 arch/arm/boot/dts/sun5i-a13.dtsi                  | 110 +++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 145 ++++++++++-
 drivers/clk/sunxi/clk-factors.c                   |  63 +----
 drivers/clk/sunxi/clk-factors.h                   |  16 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 297 +++++++++++++++++++++-
 8 files changed, 784 insertions(+), 93 deletions(-)

-- 
1.8.4
