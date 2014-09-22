From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 22 Sep 2014 12:08:22 +0200
Subject: [GIT PULL v2] second bunch of dts changes for 3.18
In-Reply-To: <2327307.ElC8r2sVBq@diego>
References: <2327307.ElC8r2sVBq@diego>
Message-ID: <3213678.LykASQ2bmb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

this is a revised pull request of the original "second bunch of dts changes"
as two issues cropped up that get fixed by

      ARM: dts: rockchip: fix swapped Radxa Rock pinctrl references
      ARM: dts: rockchip: fix rk3188 emmc pull references

so please pull

The following changes since commit f23a6179d45e9d144bf2eb2bd82b2f1270f85fcf:

  ARM: dts: rockchip: add saradc nodes (2014-08-27 23:43:01 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-dts2-v2

for you to fetch changes up to 6051ddd4f94894cce8fde3aa29f90ae6c567fc46:

  ARM: dts: rockchip: Remove "regulator-always-on" in vcc_rmii for Radxa Rock (2014-09-22 11:53:39 +0200)

----------------------------------------------------------------
More peripheral support for Rockchip SoCs
- dwc2 usb controllers
- spi controllers
- emmc controller

----------------------------------------------------------------
Addy Ke (1):
      ARM: dts: Add sdio0 and sdio1 to the rk3288

Doug Anderson (3):
      ARM: dts: Add mshc aliases for rk3288
      ARM: dts: Add rk808 PMIC to rk3288-evb-rk808
      ARM: dts: Switch i2c0 to 400kHz on rk3288-evb-rk808

Heiko Stuebner (8):
      ARM: dts: rockchip: remove rockchip,bus-index from rk3xxx i2c0
      ARM: dts: rockchip: add dwc2 controllers for rk3066 and rk3188
      ARM: dts: rockchip: enable usb ports on Radxa Rock
      ARM: dts: rockchip: add Cortex-A9 SPI controller nodes
      ARM: dts: rockchip: add emmc nodes for rk3066 and rk3188
      ARM: dts: rockchip: clean up rk3xxx mmc nodes
      ARM: dts: rockchip: fix swapped Radxa Rock pinctrl references
      ARM: dts: rockchip: fix rk3188 emmc pull references

Kever Yang (2):
      ARM: dts: add rk3288 dwc2 controller support
      ARM: dts: Enable USB host1(dwc) on rk3288-evb

Romain Perier (1):
      ARM: dts: rockchip: Remove "regulator-always-on" in vcc_rmii for Radxa Rock

huang lin (1):
      ARM: dts: Add SPI nodes to rk3288

 arch/arm/boot/dts/rk3066a.dtsi         |  67 ++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts |  44 ++++++-
 arch/arm/boot/dts/rk3188.dtsi          |  69 +++++++++++
 arch/arm/boot/dts/rk3288-evb-rk808.dts | 132 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288-evb.dtsi      |   4 +
 arch/arm/boot/dts/rk3288.dtsi          | 218 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi          |  61 ++++++++-
 7 files changed, 589 insertions(+), 6 deletions(-)
