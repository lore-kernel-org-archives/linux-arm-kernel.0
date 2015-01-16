From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Sat, 17 Jan 2015 02:11:53 +0900
Subject: [PATCH v2 0/3] add support for Firefly-RK3288 and Rayeager PX2 boards
Message-ID: <1421428316-26008-1-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for following Rockchip SoC based boards.

 - Firefly, Firefly-RK3288 (both beta and mass production version)
 - ChipSPARK, Rayeager PX2

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
 arch/arm/boot/dts/rk3066a-rayeager.dts             | 470 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-beta.dts          |  71 +++
 arch/arm/boot/dts/rk3288-firefly.dts               |  71 +++
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 490 +++++++++++++++++++++
 7 files changed, 1118 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-rayeager.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-beta.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dtsi

-- 
2.2.2
