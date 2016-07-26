From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:28 +0200
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
Message-ID: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the previous A64 patches made by Andre [1], reworked to use
the new sunxi-ng clock framework.

This uses the current H3 clock code, as both are really similar. The
first patches are just meant to rework slightly the H3 code, before
introducing the A64-related patches.

Some WiP stuff have been removed, such as the MMC part, but this serie
already has a decent amount of devices supported: uart, i2c, rsb, etc.

Let me know what you think,
Maxime

1: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/410338.html

Andre Przywara (5):
  arm64: sunxi: Kconfig: add essential pinctrl driver
  arm64: Kconfig: sunxi: add PINCTRL
  Documentation: devicetree: add vendor prefix for Pine64
  arm64: dts: add Allwinner A64 SoC .dtsi
  arm64: dts: add Pine64 support

Maxime Ripard (8):
  clk: sunxi-ng: mux: Rename mux macro to be consistent
  clk: sunxi-ng: mux: Add mux table support
  clk: sunxi-ng: sun8i: Rename DDR and video plls
  clk: sunxi-ng: sun8i: Fix register offset
  clk: sunxi-ng: sun8i: Rename H3 only clocks
  clk: sunxi-ng: sun8i: Move fixed factors around
  clk: sunxi-ng: sun8i: Prefix clock defines by SoC Name
  clk: sunxi-ng: Add A64 clocks

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  62 +-
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  50 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  70 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 273 +++++++
 drivers/clk/sunxi-ng/Kconfig                       |  13 +-
 drivers/clk/sunxi-ng/Makefile                      |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |  68 ++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                | 896 ++++++++++++++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |  44 +-
 drivers/clk/sunxi-ng/ccu_div.h                     |   2 +-
 drivers/clk/sunxi-ng/ccu_mp.h                      |   2 +-
 drivers/clk/sunxi-ng/ccu_mux.c                     |  14 +
 drivers/clk/sunxi-ng/ccu_mux.h                     |  29 +-
 include/dt-bindings/clock/sun50i-a64-ccu.h         | 132 +++
 include/dt-bindings/clock/sun8i-h3-ccu.h           | 188 ++---
 include/dt-bindings/reset/sun50i-a64-ccu.h         |  97 +++
 23 files changed, 1588 insertions(+), 366 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
 create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h

-- 
2.9.2
