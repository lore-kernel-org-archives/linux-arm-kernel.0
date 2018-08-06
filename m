From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 06 Aug 2018 10:46:03 +0200
Subject: [GIT PULL] Rockchip dts64 updates for 4.19 round 3
In-Reply-To: <2000491.bLgWuj0xar@phil>
References: <2000491.bLgWuj0xar@phil>
Message-ID: <2105931.jBd9xt4tCK@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

with Linus doing an -rc8 this time, I thought I send off some more
things that became ready since the round2 pull from last week.

As the tag describes a new soc, 2 new boards and 1 UHS support.

No worries, if you haven't got the time to look at it. Then I'll just move
things over to 4.20

Thanks
Heiko

The following changes since commit 0fbfe10fa96b8df44cfb140a6672f9418e16a2a6:

  arm64: dts: rockchip: add led support for Firefly-RK3399 (2018-07-25 12:19:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.19-rockchip-dts64-3

for you to fetch changes up to 504705e0c2113776d5836035667977a6d2fc0789:

  arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc (2018-08-04 15:16:53 +0200)

----------------------------------------------------------------
Some more things that became ripe since the last pull:
One new SoC, the PX30 targetting IoT things it seems which uses
quad-core Cortex-A35 cores and a Mali-G31.
Two new boards, the evaluation board for the PX30 as well as
the roc-rk3399-pc from Libre Computer and Firefly.
And the addition of UHS support for roc-rk3328-cc which uses
the newly added syscon-gpio support for voltage switching.

----------------------------------------------------------------
Elaine Zhang (1):
      clk: rockchip: add dt-binding header for px30

Heiko Stuebner (1):
      Merge branch 'v4.19-shared/clkids' into v4.19-armsoc/dts64

Levin Du (4):
      arm64: dts: rockchip: add support for ROC-RK3399-PC board
      arm64: dts: rockchip: add io-domain to roc-rk3328-cc
      arm64: dts: rockchip: add GRF GPIO controller to rk3328
      arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc

Liang Chen (3):
      dt-bindings: rockchip: grf: add grf and pmugrf description for px30
      arm64: dts: rockchip: add core dtsi file for PX30 SoCs
      arm64: dts: rockchip: add PX30 evaluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    8 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 arch/arm64/boot/dts/rockchip/Makefile              |    2 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  231 +++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2016 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |   30 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    7 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts     |  680 +++++++
 include/dt-bindings/clock/px30-cru.h               |  389 ++++
 9 files changed, 3364 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
 create mode 100644 include/dt-bindings/clock/px30-cru.h
