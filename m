From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Sep 2018 15:55:15 +0200
Subject: [GIT PULL] Rockchip ARM64 devicetree updates for 4.20
Message-ID: <2349272.dkc8ODN2Us@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below the first set of arm64 dt updates for 4.20
(or however it will be named).

It's really only 64 bit changes so far [I have one 32bit patch queued up,
but that isn't really useful on its own, so I'll keep it a bit longer,
to not send needless 1-patch pull requests ;-) ]

The tag describes the included changes, so if ok please pull

Thanks
Heiko


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64-1

for you to fetch changes up to 78f26da3ffbce0ea3692a89fe3f5487cb8dda068:

  arm64: dts: rockchip: Add type-c port supply on rk3399-sapphire board (2018-09-10 19:16:26 +0200)

----------------------------------------------------------------
New soc support for the px30 quad-core Cortex-A35.
New boards are the px30 eval board and roc-rk3399-pc.
The rk3328 got support for the one gpio controlled via the general
register files and the rk3399 finally got its idle-states defined.
And finally fixes and improvements for firefly-rk3399 (wifi),
roc-rk3328-cc (sdmmc-uhs, io-domains), rk3328-rock64 (gpio-regulator
pin fix) and rk3399-sapphire (gpio-regulator pin fix, pmic pin fix
and type-c port supply).

----------------------------------------------------------------
Katsuhiro Suzuki (1):
      arm64: dts: rockchip: fix vcc_host1_5v pin assign on rk3328-rock64

Levin Du (4):
      arm64: dts: rockchip: add support for ROC-RK3399-PC board
      arm64: dts: rockchip: add io-domain to roc-rk3328-cc
      arm64: dts: rockchip: add GRF GPIO controller to rk3328
      arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc

Liang Chen (3):
      dt-bindings: rockchip: grf: add grf and pmugrf description for px30
      arm64: dts: rockchip: add core dtsi file for PX30 SoCs
      arm64: dts: rockchip: add PX30 evaluation board devicetree

Sandy Huang (1):
      arm64: dts: rockchip: add missing vop properties for px30

Shohei Maruyama (1):
      arm64: dts: rockchip: add WiFi module support for Firefly-RK3399

Tony Xie (1):
      arm64: dts: rockchip: Add idle-states to device tree for rk3399

Vicente Bergas (4):
      arm64: dts: rockchip: re-order vcc_sys on rk3399-sapphire
      arm64: dts: rockchip: Fix VCC5V0_HOST_EN on rk3399-sapphire
      arm64: dts: rockchip: remove dvs2 pinctrl from pmic on rk3399-sapphire
      arm64: dts: rockchip: Add type-c port supply on rk3399-sapphire board

 Documentation/devicetree/bindings/arm/rockchip.txt |    8 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 arch/arm64/boot/dts/rockchip/Makefile              |    2 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  231 +++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2031 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |   30 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    4 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    7 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |   36 +
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts     |  680 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |   44 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   28 +
 12 files changed, 3083 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
