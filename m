From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  2 May 2015 13:24:31 +0200
Subject: [PATCH 0/8] clk: sunxi: Add support for the Audio PLL
Message-ID: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie adds support for the PLL2 aka the Audio PLL on the
Allwinner A10 and the later SoCs.

This is the first stepping stone to get the audio support merged.

Thanks!
Maxime

Emilio L?pez (5):
  clk: sunxi: codec clock support
  clk: sunxi: mod1 clock support
  ARM: sunxi: Add PLL2 support
  ARM: sunxi: Add codec clock support
  ARM: sun7i: Add mod1 clock nodes

Maxime Ripard (3):
  clk: sunxi: factors: Add m_start parameters
  clk: sunxi: factors: Add a parameter for N and M zeros
  clk: sunxi: Add a driver for the PLL2

 arch/arm/boot/dts/sun4i-a10.dtsi           |  18 +++
 arch/arm/boot/dts/sun5i.dtsi               |  18 +++
 arch/arm/boot/dts/sun7i-a20.dtsi           |  73 ++++++++++++
 drivers/clk/sunxi/Makefile                 |   3 +
 drivers/clk/sunxi/clk-a10-codec.c          |  45 ++++++++
 drivers/clk/sunxi/clk-a10-mod1.c           |  85 ++++++++++++++
 drivers/clk/sunxi/clk-a10-pll2.c           | 176 +++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-factors.c            |  17 ++-
 drivers/clk/sunxi/clk-factors.h            |   5 +
 drivers/clk/sunxi/clk-mod0.c               |   2 +
 drivers/clk/sunxi/clk-sun8i-mbus.c         |   2 +
 drivers/clk/sunxi/clk-sun9i-core.c         |   6 +
 drivers/clk/sunxi/clk-sunxi.c              |  10 ++
 include/dt-bindings/clock/sun4i-a10-pll2.h |  53 +++++++++
 14 files changed, 512 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi/clk-a10-codec.c
 create mode 100644 drivers/clk/sunxi/clk-a10-mod1.c
 create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c
 create mode 100644 include/dt-bindings/clock/sun4i-a10-pll2.h

-- 
2.3.6
