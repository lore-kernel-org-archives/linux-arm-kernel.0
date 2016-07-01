From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 01 Jul 2016 02:19:25 +0200
Subject: [GIT PULL 1/2] Rockchip dts32 changes for 4.8
Message-ID: <1666093.aVfPg2VmbT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below arm devicetree changes for 4.8. The biggest part is
probably the support for audio on veyron devices where the renaming was
coordinated with the alsa side and the overturned name was never part of
an actual release.

Apart from that Veyron also got a node for its spi flash and we now also
support the ethernet and i2s controller on the rk3228/rk3229 siblings.

So if it looks ok, please pull

Thanks
Heiko


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.8-rockchip-dts32-1

for you to fetch changes up to 241eff3c198492b2d63e75723b774f2836fee8a3:

  ARM: dts: rockchip: add support rk3229 evb board (2016-06-27 21:38:50 +0200)

----------------------------------------------------------------
Audio support and spi-flash on rk3288-veyron Chromedevices
as well as i2s and ethernet support on rk3228/rk3229 devices
and a dts file for the rk3229 eval board.

----------------------------------------------------------------
Brian Norris (1):
      ARM: dts: rockchip: add SPI flash node for rk3288-veyron

Enric Balletbo i Serra (2):
      ARM: dts: rockchip: Add shared file for audio on rk3288-veyron boards
      ARM: dts: rockchip: Enable analog audio on rk3288-veyron chromebooks

Heiko Stuebner (3):
      ARM: dts: rockchip: move rk3288 io-domain nodes to the grf
      ARM: dts: rockchip: rename i2s model for Veyron devices
      Merge branch 'v4.8-shared/clkids' into v4.8-armsoc/dts32

Xing Zheng (6):
      clk: rockchip: add clock-ids for rk3228 audio clocks
      clk: rockchip: add clock-ids for rk3228 MAC clocks
      ARM: dts: rockchip: rename rk3228.dtsi to rk322x.dtsi
      ARM: dts: rockchip: add i2s nodes for RK322x SoCs
      ARM: dts: rockchip: add GMAC nodes for RK322x SoCs
      ARM: dts: rockchip: add support rk3229 evb board

 Documentation/devicetree/bindings/arm/rockchip.txt |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3228-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3229-evb.dts                   |  90 ++++++++++++++++
 arch/arm/boot/dts/{rk3228.dtsi => rk322x.dtsi}     | 118 ++++++++++++++++++++-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  31 +++---
 arch/arm/boot/dts/rk3288-miqi.dts                  |  26 ++---
 arch/arm/boot/dts/rk3288-popmetal.dts              |  31 +++---
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |  31 +++---
 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi  | 101 ++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    |   1 +
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  31 +++---
 arch/arm/boot/dts/rk3288.dtsi                      |   5 +
 include/dt-bindings/clock/rk3228-cru.h             |  15 +++
 14 files changed, 409 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229-evb.dts
 rename arch/arm/boot/dts/{rk3228.dtsi => rk322x.dtsi} (80%)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
