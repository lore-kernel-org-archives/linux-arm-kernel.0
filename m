From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 03 Oct 2018 03:38:46 +0200
Subject: [GIT PULL 1/3] Rockchip ARM64 devicetree updates for 4.20 - round2
Message-ID: <2559110.ail6FZQ9dJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below and in the following pull-requests more rockchip
changes targetted at 4.20.

Nice mix of new boards and some improvements + fixes as described
in the tags. So please pull.

Thanks
Heiko


The following changes since commit 78f26da3ffbce0ea3692a89fe3f5487cb8dda068:

  arm64: dts: rockchip: Add type-c port supply on rk3399-sapphire board (2018-09-10 19:16:26 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64-2

for you to fetch changes up to e78d53c7b2873e0724eb765a88ccde42560b0e05:

  arm64: dts: rockchip: enable display nodes on rk3328-rock64 (2018-09-28 13:18:37 +0200)

----------------------------------------------------------------
Some additional new boards, the rk3399-based RockPro64 from Pine64, as well
as the Vamrs Rock960. Another big feature is display support including hdmi
and the Innosilicon hdmiphy on the rk3328, right now enabled on the rock64.
The rock64 also got its spi-nor and spdif enabled. On the px30 we can see
dwc2-based usb support now and finally some misc fixes, like for a new dtc
warning, missing address and size cells and microSD fix on sapphire.

----------------------------------------------------------------
Akash Gajjar (1):
      arm64: dts: rockchip: add initial dts support for Rockpro64

Chen-Yu Tsai (1):
      arm64: dts: rockchip: Enable SPI NOR flash on Rock64

Heiko Stuebner (6):
      arm64: dts: rockchip: add dwc2 otg controller on px30
      arm64: dts: rockchip: enable dwc2-based otg controller on px30-evb
      arm64: dts: rockchip: add missing address and size cells for rk3399 mipi dsi
      arm64: dts: rockchip: add Innosilicon hdmi phy node to rk3328
      arm64: dts: rockchip: add rk3328 display nodes
      arm64: dts: rockchip: enable display nodes on rk3328-rock64

Katsuhiro Suzuki (1):
      arm64: dts: rockchip: add spdif sound node for rock64

Liang Chen (1):
      dt-bindings: usb: dwc2: add description for px30

Manivannan Sadhasivam (4):
      arm64: dts: rockchip: Split out common nodes for Rock960 based boards
      dt-bindings: arm: rockchip: Add binding for Rock960 board
      arm64: dts: rockchip: Add support for Rock960 board
      arm64: dts: rockchip: Enable SD card detection for Rock960 boards

Rob Herring (1):
      arm64: dts: rockchip: Fix I2C bus unit-address error on rk3399-puma-haikou

Vicente Bergas (1):
      arm64: dts: rockchip: Fix microSD in rk3399 sapphire board

 Documentation/devicetree/bindings/arm/rockchip.txt |   8 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |   1 +
 arch/arm64/boot/dts/rockchip/Makefile              |   2 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |   4 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  16 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  57 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  67 ++
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      | 524 +---------------
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts    |  52 ++
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   | 542 ++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  | 692 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |  24 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   4 +
 14 files changed, 1474 insertions(+), 521 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
