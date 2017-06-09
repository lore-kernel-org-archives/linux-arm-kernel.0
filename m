From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 09 Jun 2017 12:14:36 +0200
Subject: [GIT PULL 2/3] Rockchip dts64 updates for 4.13 part1
In-Reply-To: <2090243.QTRV0U63fj@phil>
References: <2090243.QTRV0U63fj@phil>
Message-ID: <3220808.DiVK6dvI90@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.13-rockchip-dts64-1

for you to fetch changes up to 5fd3ffb92d33f86a5c0757ef879f7d785beeec92:

  arm64: dts: rockchip: update common rk3399 operating points (2017-05-30 12:12:07 +0200)

----------------------------------------------------------------
Support for the new rk3399 firefly board; extending the pcie ranges to
make usage of pci switches possible; some more qos and pinctrl nodes on
rk3399; updates for the rk3399 cpu operating points including separate
opps for the higher rates OP1 variant of the chip and mmc-nodes for
the rk3328.

----------------------------------------------------------------
Heiko Stuebner (5):
      arm64: dts: rockchip: bring rk3399-firefly power-tree in line
      arm64: dts: rockchip: add ethernet0 alias on rk3399
      arm64: dts: rockchip: enable usb3 controllers on rk3399-firefly
      arm64: dts: rockchip: introduce rk3399-op1 operating points
      arm64: dts: rockchip: update common rk3399 operating points

Kever Yang (4):
      dt-bindings: add firefly-rk3399 board support
      arm64: dts: rockchip: add support for firefly-rk3399 board
      arm64: dts: rockchip: add some missing qos nodes on rk3399
      arm64: dts: rockchip: add pinctrl settings for some rk3399 peripherals

Shawn Lin (3):
      arm64: dts: rockchip: extent bus-ranges of PCIe for rk3399
      arm64: dts: rockchip: extent IORESOURCE_MEM_64 of PCIe for rk3399
      arm64: dts: rockchip: add sdmmc/sdio/emmc nodes for RK3328 SoCs

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  33 +
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    | 718 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi   | 145 +++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       |  18 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 165 ++++-
 8 files changed, 1064 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
