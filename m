From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Nov 2012 15:48:32 +0100
Subject: [GIT PULL] i.MX SoC updates
Message-ID: <20121122144832.GI10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another bunch of i.MX SoC updates, based on arm-soc/imx/soc. Please
pull.

Sascha


The following changes since commit d6aef84a48fa54ac606ae719fcd125199939f43d:

  ARM i.MX51 babbage: Add display support (2012-11-16 16:34:18 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-soc-1

for you to fetch changes up to 2b254693bef4f1299de0afb231890fe348df11c6:

  ARM i.MX6: remove gate_mask from pllv3 (2012-11-22 15:32:39 +0100)

----------------------------------------------------------------
ARM i.MX SoC updates for v3.8

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: mx5: Replace clk_register_clkdev with clock DT lookup

Sascha Hauer (6):
      ARM i.MX53: Add pwm support
      ARM i.MX51: Add pwm support
      ARM i.MX6: Add pwm support
      ARM i.MX6: rename PLLs according to datasheet
      ARM i.MX6: Fix ethernet PLL clocks
      ARM i.MX6: remove gate_mask from pllv3

 .../devicetree/bindings/clock/imx5-clock.txt       |  191 ++++++++++++++++++++
 .../devicetree/bindings/clock/imx6q-clock.txt      |    9 +-
 arch/arm/boot/dts/imx51.dtsi                       |   57 ++++++
 arch/arm/boot/dts/imx53.dtsi                       |   66 +++++++
 arch/arm/boot/dts/imx6q.dtsi                       |   16 ++
 arch/arm/mach-imx/clk-imx51-imx53.c                |   26 +--
 arch/arm/mach-imx/clk-imx6q.c                      |   40 ++--
 arch/arm/mach-imx/clk-pllv3.c                      |   72 +-------
 arch/arm/mach-imx/clk.h                            |    3 +-
 arch/arm/mach-imx/imx51-dt.c                       |   28 +--
 arch/arm/mach-imx/mach-imx53.c                     |   31 +---
 11 files changed, 386 insertions(+), 153 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
