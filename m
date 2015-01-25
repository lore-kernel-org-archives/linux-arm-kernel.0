From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Sun, 25 Jan 2015 21:39:33 +0900
Subject: [PATCH v4 0/3] add support for Firefly-RK3288 and Rayeager PX2 boards
Message-ID: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for following Rockchip SoC based boards.

 - Firefly, Firefly-RK3288 (both beta and mass production version)
 - ChipSPARK, Rayeager PX2

Changes in v4:
- revert wrong clock-* fixes in v3
- remove non-working tsadc
- remove spi2 which uses only clk and cs0 pins
- remove vqmmc-supply from sdmmc and keep vccio_sd 3.3V to make SD card works
- update gmac regulator properties to match with recent Romain Perier's change

Changes in v3:
- fix ordering more
- fix clock-* properties
- enable tsadc with clock-* properties

Changes in v2:
- use own compatible property for Firefly-RK3288 beta version
- remove disabled tsadc node
- add missing vin-supply
- use two chars for i2c address
- fix ordering for the nodes without address element
- add commit messages

FUKAUMI Naoki (3):
  dt-bindings: add vendor prefix and root compatible property for
    Rockchip boards
  ARM: dts: rockchip: add dts for Firefly Firefly-RK3288 boards
  ARM: dts: rockchip: add dts for ChipSPARK Rayeager PX2 board

 Documentation/devicetree/bindings/arm/rockchip.txt |  10 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts             | 468 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-beta.dts          |  71 +++
 arch/arm/boot/dts/rk3288-firefly.dts               |  71 +++
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 483 +++++++++++++++++++++
 7 files changed, 1109 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-rayeager.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-beta.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dtsi

-- 
2.2.2
