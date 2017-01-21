From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 Jan 2017 01:11:25 +0100
Subject: [GIT PULL 2/3] Rockchip dts32 updates for 4.11 part1
In-Reply-To: <6458001.3c0YmcoF8y@phil>
References: <6458001.3c0YmcoF8y@phil>
Message-ID: <1581407.91s7OzFVNJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.11-rockchip-dts32-1

for you to fetch changes up to ec7c98ec9b8dd2c04ed75cad88e91eebedbb1a25:

  ARM: dts: rockchip: add soc-specific uart compatibles for rk3066/rk3188 (2017-01-19 17:04:44 +0100)

----------------------------------------------------------------
Bit of cleanup for the cortex-a9 uarts to have that soc-specific
spare-compatible as all others have, conversion to gpio constants
and addition of rk3288 qos nodes that need to be saved before a
power-domain gets turned off.

----------------------------------------------------------------
Andy Yan (1):
      ARM: dts: rockchip: use pin constants to describe gpios

Elaine Zhang (1):
      ARM: dts: rockchip: add qos node for rk3288

Heiko Stuebner (1):
      ARM: dts: rockchip: add soc-specific uart compatibles for rk3066/rk3188

 arch/arm/boot/dts/rk3036-evb.dts                  |  2 +-
 arch/arm/boot/dts/rk3036-kylin.dts                | 12 ++--
 arch/arm/boot/dts/rk3066a-bqcurie2.dts            |  8 +--
 arch/arm/boot/dts/rk3066a-marsboard.dts           |  6 +-
 arch/arm/boot/dts/rk3066a-mk808.dts               | 10 +--
 arch/arm/boot/dts/rk3066a-rayeager.dts            | 18 ++---
 arch/arm/boot/dts/rk3066a.dtsi                    |  4 ++
 arch/arm/boot/dts/rk3188-px3-evb.dts              | 10 +--
 arch/arm/boot/dts/rk3188-radxarock.dts            | 20 +++---
 arch/arm/boot/dts/rk3188.dtsi                     |  4 ++
 arch/arm/boot/dts/rk3229-evb.dts                  |  2 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts          |  6 +-
 arch/arm/boot/dts/rk3288-evb-rk808.dts            |  2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                 | 14 ++--
 arch/arm/boot/dts/rk3288-fennec.dts               |  6 +-
 arch/arm/boot/dts/rk3288-firefly-beta.dts         |  2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi |  2 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts       | 26 +++----
 arch/arm/boot/dts/rk3288-firefly.dts              |  2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi             | 18 ++---
 arch/arm/boot/dts/rk3288-miqi.dts                 |  8 +--
 arch/arm/boot/dts/rk3288-popmetal.dts             |  8 +--
 arch/arm/boot/dts/rk3288-r89.dts                  | 14 ++--
 arch/arm/boot/dts/rk3288-rock2-som.dtsi           |  4 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts         | 14 ++--
 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi |  8 +--
 arch/arm/boot/dts/rk3288-veyron-brain.dts         |  8 +--
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi   | 14 ++--
 arch/arm/boot/dts/rk3288-veyron-jaq.dts           | 14 ++--
 arch/arm/boot/dts/rk3288-veyron-jerry.dts         | 12 ++--
 arch/arm/boot/dts/rk3288-veyron-mickey.dts        |  6 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts        | 18 ++---
 arch/arm/boot/dts/rk3288-veyron-pinky.dts         |  4 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi        |  2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts        | 10 +--
 arch/arm/boot/dts/rk3288-veyron.dtsi              | 10 +--
 arch/arm/boot/dts/rk3288.dtsi                     | 84 +++++++++++++++++++++++
 37 files changed, 252 insertions(+), 160 deletions(-)
