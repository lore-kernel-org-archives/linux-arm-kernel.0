From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 Sep 2016 22:10:25 +0200
Subject: [PATCH v2 0/4] arm64: Allwinner A64 support based on sunxi-ng
Message-ID: <20160909201029.24530-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As it was in the first iteration, this is the A64 support based on the
new sunxi-ng clock framework.

The support for it is quite minimal at the moment, but it should be
fairly easy to add new devices, as most of the design is shared with
older SoCs.

Let me know what you think,
Maxime

Changes from v1:
  - Split the A64 CCU support out of the H3 driver
  - Added the PMU support
  - Removed the clocks node
  - Rebased on top of current sunxi/clk-for-4.9 branch

Andre Przywara (3):
  Documentation: devicetree: add vendor prefix for Pine64
  arm64: dts: add Allwinner A64 SoC .dtsi
  arm64: dts: add Pine64 support

Maxime Ripard (1):
  clk: sunxi-ng: Add A64 clocks

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  50 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  70 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 279 +++++++
 drivers/clk/sunxi-ng/Kconfig                       |  11 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              | 870 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |  68 ++
 include/dt-bindings/clock/sun50i-a64-ccu.h         | 132 ++++
 include/dt-bindings/reset/sun50i-a64-ccu.h         |  97 +++
 15 files changed, 1588 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
 create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h

-- 
2.9.3
