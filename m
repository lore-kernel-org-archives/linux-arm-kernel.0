From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 20:00:28 +0200
Subject: [PATCH v5 0/4] arm64: Allwinner A64 support based on sunxi-ng
Message-ID: <cover.f18c0f482ef4459b5c8f6eb5828fcb6762440974.1476986335.git-series.maxime.ripard@free-electrons.com>
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

Changes from v4:
  - Removed merged patches and added Chen-Yu's Acked by
  - Fixed the interrupt-cells property to 3
  - Fixed the rtc order
  - Added the CLK_SET_RATE_UNGATE flags to the PLLs
  - Added the CLK_SET_RATE_PARENT flags to the cpu clock
  - Fixed a few offset and width

Changes from v3:
  - Fix patch split

Changes from v2:
  - Added pull-ups on the Pine64 i2c bus
  - Removed the PMU since it doesn't work
  - Refactored the sunxi-ng framework to deal with the specifities of
    the A64 CCU, especially in terms of minimum factors.
  - Fixed a few things in the CCU driver: added CLK_SET_RATE PARENT
    flags, fixed some mux width, etc.
  - Converted the CCU driver to a platform driver
  - Added the DRAM reset line
  - Added IDs for the USB muxes (even though we're not using them yet)

Changes from v1:
  - Split the A64 CCU support out of the H3 driver
  - Added the PMU support
  - Removed the clocks node
  - Rebased on top of current sunxi/clk-for-4.9 branch

Andre Przywara (3):
  arm64: dts: add Allwinner A64 SoC .dtsi
  Documentation: devicetree: add vendor prefix for Pine64
  arm64: dts: add Pine64 support

Maxime Ripard (1):
  clk: sunxi-ng: Add A64 clocks

 Documentation/devicetree/bindings/arm/sunxi.txt          |   1 +-
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt    |   1 +-
 Documentation/devicetree/bindings/vendor-prefixes.txt    |   2 +-
 MAINTAINERS                                              |   1 +-
 arch/arm64/boot/dts/Makefile                             |   1 +-
 arch/arm64/boot/dts/allwinner/Makefile                   |   5 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts |  50 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts      |  74 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi            | 263 ++-
 drivers/clk/sunxi-ng/Kconfig                             |  11 +-
 drivers/clk/sunxi-ng/Makefile                            |   1 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c                    | 917 ++++++++-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h                    |  72 +-
 include/dt-bindings/clock/sun50i-a64-ccu.h               | 134 +-
 include/dt-bindings/reset/sun50i-a64-ccu.h               |  98 +-
 15 files changed, 1630 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
 create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h

-- 
git-series 0.8.10
