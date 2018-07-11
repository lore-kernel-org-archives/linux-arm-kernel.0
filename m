From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 11 Jul 2018 16:28:59 +0200
Subject: [GIT PULL 1/2] Rockchip dts32 updates for 4.19 round 1
In-Reply-To: <2000491.bLgWuj0xar@phil>
References: <2000491.bLgWuj0xar@phil>
Message-ID: <1895379.zdtPBogyMs@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below the first part of Rockchip devicetree updates
targetted at 4.19.

Biggest change from a volume point for both 32 and 64bit is of course
the conversion to spdx tags. The conversion patches were available on
the mailing lists for around 6 months, got some Acks, other key players
already submitted new devicetrees with spdx tags and there were no
complaints at all. So as this isn't even a license change but merely
just a different form of boilerplate, I think that should be enough
consensus for it.

Other than that we a new Gru board, some fixes for missing cooling
device properties sound improvements for rk3399 and some odd fixes.

If nothing stands out, please pull!


Thanks
Heiko


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.19-rockchip-dts32-1

for you to fetch changes up to f999d76a0011abfd814c8513a5e60a7eb9b9dac0:

  ARM: dts: rockchip: Add missing cooling device properties for CPUs on rk3288 (2018-06-18 12:31:52 +0200)

----------------------------------------------------------------
SPDX conversion for existing Rockchip devicetree files as well
as conversion of rk3288 to OPPv2 to facilitate the addition of
missing cpu-cooling-device properties.

----------------------------------------------------------------
Heiko Stuebner (1):
      ARM: dts: rockchip: convert rk3288 to operating-points-v2

Klaus Goger (1):
      ARM: dts: rockchip: use SPDX-License-Identifier

Viresh Kumar (2):
      ARM: dts: rockchip: Add missing cooling device properties for CPUs on rk322x
      ARM: dts: rockchip: Add missing cooling device properties for CPUs on rk3288

 arch/arm/boot/dts/rk3036-evb.dts                  |  40 +------
 arch/arm/boot/dts/rk3036-kylin.dts                |  40 +------
 arch/arm/boot/dts/rk3036.dtsi                     |  40 +------
 arch/arm/boot/dts/rk3066a-bqcurie2.dts            |  39 +------
 arch/arm/boot/dts/rk3066a-marsboard.dts           |  39 +------
 arch/arm/boot/dts/rk3066a-mk808.dts               |  39 +------
 arch/arm/boot/dts/rk3066a-rayeager.dts            |  39 +------
 arch/arm/boot/dts/rk3066a.dtsi                    |  39 +------
 arch/arm/boot/dts/rk3188-px3-evb.dts              |  39 +------
 arch/arm/boot/dts/rk3188-radxarock.dts            |  39 +------
 arch/arm/boot/dts/rk3188.dtsi                     |  39 +------
 arch/arm/boot/dts/rk3228-evb.dts                  |  40 +------
 arch/arm/boot/dts/rk3229-evb.dts                  |  40 +------
 arch/arm/boot/dts/rk3229.dtsi                     |  39 +------
 arch/arm/boot/dts/rk322x.dtsi                     |  43 +-------
 arch/arm/boot/dts/rk3288-evb-act8846.dts          |  40 +------
 arch/arm/boot/dts/rk3288-evb-rk808.dts            |  40 +------
 arch/arm/boot/dts/rk3288-evb.dtsi                 |  40 +------
 arch/arm/boot/dts/rk3288-fennec.dts               |  40 +------
 arch/arm/boot/dts/rk3288-firefly-beta.dts         |  39 +------
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi |  39 +------
 arch/arm/boot/dts/rk3288-firefly-reload.dts       |  39 +------
 arch/arm/boot/dts/rk3288-firefly.dts              |  39 +------
 arch/arm/boot/dts/rk3288-firefly.dtsi             |  39 +------
 arch/arm/boot/dts/rk3288-miqi.dts                 |  39 +------
 arch/arm/boot/dts/rk3288-phycore-rdk.dts          |  39 +------
 arch/arm/boot/dts/rk3288-phycore-som.dtsi         |  39 +------
 arch/arm/boot/dts/rk3288-popmetal.dts             |  39 +------
 arch/arm/boot/dts/rk3288-r89.dts                  |  39 +------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi           |  40 +------
 arch/arm/boot/dts/rk3288-rock2-square.dts         |  40 +------
 arch/arm/boot/dts/rk3288-tinker.dts               |  39 +------
 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi |   5 +-
 arch/arm/boot/dts/rk3288-veyron-brain.dts         |  39 +------
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi   |  39 +------
 arch/arm/boot/dts/rk3288-veyron-jaq.dts           |  39 +------
 arch/arm/boot/dts/rk3288-veyron-jerry.dts         |  39 +------
 arch/arm/boot/dts/rk3288-veyron-mickey.dts        |  39 +------
 arch/arm/boot/dts/rk3288-veyron-minnie.dts        |  39 +------
 arch/arm/boot/dts/rk3288-veyron-pinky.dts         |  39 +------
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi        |  39 +------
 arch/arm/boot/dts/rk3288-veyron-speedy.dts        |  39 +------
 arch/arm/boot/dts/rk3288-veyron.dtsi              |  75 ++++---------
 arch/arm/boot/dts/rk3288-vyasa.dts                |  39 +------
 arch/arm/boot/dts/rk3288.dtsi                     | 122 ++++++++++++----------
 arch/arm/boot/dts/rk3xxx.dtsi                     |  39 +------
 arch/arm/boot/dts/rv1108-evb.dts                  |  40 +------
 arch/arm/boot/dts/rv1108.dtsi                     |  40 +------
 48 files changed, 138 insertions(+), 1836 deletions(-)
