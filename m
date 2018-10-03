From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 03 Oct 2018 03:39:29 +0200
Subject: [GIT PULL 2/3] Rockchip ARM32 devicetree updates for 4.20
In-Reply-To: <2559110.ail6FZQ9dJ@phil>
References: <2559110.ail6FZQ9dJ@phil>
Message-ID: <1670292.M4d8aT802m@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts32-1

for you to fetch changes up to 186b45657b244ce865e01b65d73868a48252e1ff:

  ARM: dts: rockchip: add rk3288-based Tinker board S (2018-09-26 14:31:30 +0200)

----------------------------------------------------------------
Nodes for the newly support rk3188 display controller, a fix for a new
dtc warning, gpio setting for the sdmmc regulator on radxarock and a
new board the "S" variant of the rk3288-based Tinker board, that sports
an added emmc.

----------------------------------------------------------------
David Summers (2):
      ARM: dts: rockchip: move shared tinker-board nodes to a common dtsi
      ARM: dts: rockchip: add rk3288-based Tinker board S

Heiko Stuebner (2):
      ARM: dts: rockchip: add rk3188 lcd controller nodes
      ARM: dts: rockchip: explicitly set vcc_sd0 pin to gpio on rk3188-radxarock

Rob Herring (1):
      ARM: dts: rockchip: Fix erroneous SPI bus dtc warnings on rk3036

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3036.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |   8 +
 arch/arm/boot/dts/rk3188.dtsi                      |  82 ++++
 arch/arm/boot/dts/rk3288-tinker-s.dts              |  26 ++
 arch/arm/boot/dts/rk3288-tinker.dts                | 498 +-------------------
 arch/arm/boot/dts/rk3288-tinker.dtsi               | 502 +++++++++++++++++++++
 8 files changed, 626 insertions(+), 497 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-tinker-s.dts
 create mode 100644 arch/arm/boot/dts/rk3288-tinker.dtsi
