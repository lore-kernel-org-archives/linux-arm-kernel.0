From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 09 Oct 2015 02:52:35 +0200
Subject: [GIT PULL 2/2] Rockchip dts32 changes for 4.4
In-Reply-To: <160496219.B4xWx83NpX@phil>
References: <160496219.B4xWx83NpX@phil>
Message-ID: <12464097.evEmzqNxWf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

these are collected devicetree changes for 4.4

so if ok, please pull

Thanks
Heiko

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.4-rockchip-dts32-1

for you to fetch changes up to b63af764ca5134341aa3a2836b356a65902ea9d4:

  ARM: dts: rockchip: add the support power-domain node on RK3288 SoCs (2015-10-08 22:41:11 +0200)

----------------------------------------------------------------
DTS changes including one new Veyron-board and the Radxa Rock2
system-on-module as well as the square baseboard. On top of that
a lot of mmc-related changes to improve speeds on the Cortex-A9
socs and also setting up the supplies for rk3288 mmc-controllers
for the following mmc-tuning support. And of course the dts-part
of the rk3288 power-domains.

----------------------------------------------------------------
Alexandru M Stan (2):
      ARM: dts: rockchip: pull up cts lines on rk3288
      ARM: dts: rockchip: Remove specific cts pullup from veyron

Brian Norris (1):
      ARM: dts: rockchip: add veyron-jaq board

Caesar Wang (2):
      dt-bindings: add power-domain header for RK3288 SoCs
      ARM: dts: rockchip: add the support power-domain node on RK3288 SoCs

Douglas Anderson (1):
      ARM: dts: rockchip: Add the hdmi-ddc pinctrl settings for rk3288

Heiko Stuebner (6):
      ARM: dts: rockchip: add rk3288-popmetal board to dtb list
      ARM: dts: rockchip: add rk3288-popmetal mmc supplies
      ARM: dts: rockchip: add rk3288-popmetal iodomains
      ARM: dts: rockchip: fixup firefly mmc supplies
      ARM: dts: rockchip: add rk3288-firefly iodomains
      Merge branch 'v4.4-armsoc/pd-headers' into v4.4-armsoc/dts32

Romain Perier (1):
      ARM: dts: rockchip: Add support for SD/MMC on MarsBoard-RK3066

Shawn Lin (2):
      ARM: dts: rockchip: support highspeed sd-cards for rk3188-radxarock
      ARM: dts: rockchip: support highspeed sd-cards on rk3066a boards

Sjoerd Simons (1):
      ARM: dts: rockchip: Add dtb for the Radxa Rock 2 Square board

 Documentation/devicetree/bindings/arm/rockchip.txt |  11 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   2 +
 arch/arm/boot/dts/rk3066a-marsboard.dts            |   8 +
 arch/arm/boot/dts/rk3066a-rayeager.dts             |   2 +
 arch/arm/boot/dts/rk3188-radxarock.dts             |   2 +
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  55 +++-
 arch/arm/boot/dts/rk3288-popmetal.dts              |  85 ++++++-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            | 277 +++++++++++++++++++++
 arch/arm/boot/dts/rk3288-rock2-square.dts          | 149 +++++++++++
 arch/arm/boot/dts/rk3288-veyron-jaq.dts            | 176 +++++++++++++
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  12 -
 arch/arm/boot/dts/rk3288.dtsi                      | 113 ++++++++-
 include/dt-bindings/power/rk3288-power.h           |  31 +++
 14 files changed, 902 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-rock2-som.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-rock2-square.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-jaq.dts
 create mode 100644 include/dt-bindings/power/rk3288-power.h
