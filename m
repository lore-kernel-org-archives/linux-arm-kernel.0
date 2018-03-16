From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Mar 2018 01:53:47 +0800
Subject: [PATCH 0/7] Allwinner A64 DE2 CCU support with dedicated DE2 bus
 driver
Message-ID: <20180316175354.21437-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset tries to implement the Allwinner A64 DE2 as a bus driver,
in order to model the fact that the SRAM claim controls the access to
the whole DE2 memory space.

PATCH 1 and PATCH 4 are for the CCU part.

PATCH 2 is the device tree binding for the A64 DE2 bus, and PATCH 3
implements the bus driver.

PATCH 5 is a modified version of A64 DE2 CCU patch, which uses the A64
DE2 bus.

PATCH 6 and 7 are just the simplefb patches for A64.

Icenowy Zheng (7):
  dt-bindings: add compatible string for the A64 DE2 CCU
  dt-bindings: add binding for the Allwinner A64 DE2 bus
  bus: add bus driver for accessing Allwinner A64 DE2
  clk: sunxi-ng: add A64 compatible string
  arm64: allwinner: a64: add DE2 CCU related device tree nodes
  arm64: allwinner: a64: add simplefb for A64 SoC
  arm64: allwinner: a64: add HDMI regulator to all DTs' simplefb_hdmi

 .../devicetree/bindings/bus/sun50i-de2-bus.txt     | 37 ++++++++++++
 .../devicetree/bindings/clock/sun8i-de2.txt        |  1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  4 ++
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |  4 ++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  4 ++
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  4 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  4 ++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 68 ++++++++++++++++++++++
 drivers/bus/Kconfig                                | 10 ++++
 drivers/bus/Makefile                               |  1 +
 drivers/bus/sun50i-de2.c                           | 49 ++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               | 11 ++--
 13 files changed, 194 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
 create mode 100644 drivers/bus/sun50i-de2.c

-- 
2.15.1
