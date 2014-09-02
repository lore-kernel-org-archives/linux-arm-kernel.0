From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Sep 2014 11:49:55 +0200
Subject: [GIT PULL] first bunch of dts changes for 3.18
Message-ID: <1937322.lt3suVLyIs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

here is a first bunch of dts changes for 3.18. A lot of material for
the rk3288 and some other smaller adaptions for changes happening
in other trees (dw_mmc conversion, accepted saradc driver in the iio tree).

So please pull


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-dts1

for you to fetch changes up to f23a6179d45e9d144bf2eb2bd82b2f1270f85fcf:

  ARM: dts: rockchip: add saradc nodes (2014-08-27 23:43:01 +0200)

----------------------------------------------------------------
First hunk of Rockchip dts changes for 3.18
- dw_mmc conversion from Jaehoon Chung
- mmc support for rk3288
- pwm + backlight for rk3288
- rtc for Radxa Rock
- saradc base nodes

----------------------------------------------------------------
Doug Anderson (5):
      ARM: dts: Add emmc and sdmmc to the rk3288 device tree
      ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards
      ARM: dts: Move the PMIC interrupt pinctrl line to rk3288-evb common
      ARM: dts: Add main PWM info to rk3288
      ARM: dts: Enable PWM backlight on rk3288-evb

Heiko St?bner (2):
      ARM: dts: rockchip: add hym8563 rtc to Radxa Rock board
      ARM: dts: rockchip: add saradc nodes

Jaehoon Chung (1):
      ARM: dts: rockchip: unuse the slot-node and deprecate the supports-highspeed for dw-mmc

 arch/arm/boot/dts/rk3066a-bqcurie2.dts   | 15 ++---
 arch/arm/boot/dts/rk3188-radxarock.dts   | 24 ++++++--
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 10 +---
 arch/arm/boot/dts/rk3288-evb.dtsi        | 83 +++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi            | 98 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi            | 10 ++++
 6 files changed, 215 insertions(+), 25 deletions(-)
