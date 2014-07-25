From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 25 Jul 2014 23:49:32 +0200
Subject: [PATCH v3 0/8] ARM: rockchip: add initial support for rk3288
Message-ID: <1406324980-2450-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the initial support for Rockchip rk3288 socs including
debug uart and devicetree files for the rk3288 evaluation board and
enables these boards to boot into an initramfs.

Boards using uboot need an updated bootloader, which must start the timer
supplying the architected timer, while the coreboot bootloader already does
this. It also depends on the patch
    "irqchip: gic: Add binding probe for ARM GIC400"
which should have made it into the irqchip tree today.

changes since v2:
- address more comments from Doug Anderson
  - move pinctrl settings to the main dtsi
  - use aliases when enabling nodes in the the evb dtsi
  - call xin24m osciallator and use clock-output-names
  - a lot of formatting and other minor cleanups
changes since v1:
- adress comments from Olof Johansson and Doug Anderson
  - remove soc parent-node
  - clarify cortex-a9 debug-uart descriptions
  - a lot of dts changes

Doug Anderson (1):
  ARM: dts: Build dtbs for Rockchip boards

Heiko Stuebner (7):
  dt-bindings: arm: add cortex-a12 and cortex-a17 cpu compatible
    properties
  ARM: rockchip: clarify usability of DEBUG_RK3X_UART debug_ll options
  ARM: rockchip: add debug uart used by rk3288
  ARM: Kconfig: set default gpio number for rockchip SoCs
  ARM: rockchip: enable support for RK3288 SoCs
  ARM: dts: rockchip: add core rk3288 dtsi
  ARM: dts: add rk3288 evaluation board

 Documentation/devicetree/bindings/arm/cpus.txt |   2 +
 arch/arm/Kconfig                               |   1 +
 arch/arm/Kconfig.debug                         |  20 +-
 arch/arm/boot/dts/Makefile                     |   5 +
 arch/arm/boot/dts/rk3288-evb-act8846.dts       | 134 ++++++
 arch/arm/boot/dts/rk3288-evb-rk808.dts         |  18 +
 arch/arm/boot/dts/rk3288-evb.dtsi              |  74 ++++
 arch/arm/boot/dts/rk3288.dtsi                  | 575 +++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig                 |   1 +
 arch/arm/mach-rockchip/rockchip.c              |   1 +
 10 files changed, 826 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-evb-act8846.dts
 create mode 100644 arch/arm/boot/dts/rk3288-evb-rk808.dts
 create mode 100644 arch/arm/boot/dts/rk3288-evb.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288.dtsi

-- 
1.9.0
