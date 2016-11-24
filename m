From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 Nov 2016 16:43:16 +0100
Subject: [GIT PULL 3/3] Rockchip dts32 changes for 4.10
In-Reply-To: <1594090.z775ZFR2cz@phil>
References: <1594090.z775ZFR2cz@phil>
Message-ID: <1575955.EYn93JYaxe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6a8883d614c7bede1075a4850139daa9723c291e:

  ARM: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max" (2016-11-09 14:46:04 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.10-rockchip-dts32-2

for you to fetch changes up to c458e1b504a6a8c817fc56b4d4704273f2c459bb:

  ARM: dts: rockchip: add the sdmmc pinctrl for rk1108 (2016-11-16 13:37:45 +0100)

----------------------------------------------------------------
A bit of attention for the rk3066, fixed tsadc reset node
as well as enabling the dma for uart and mmc controllers.

And one new soc, the rk1108 combining a single-core Cortex-A7
with a separate DSP core.

----------------------------------------------------------------
Andy Yan (2):
      ARM: dts: rockchip: add basic support for RK1108 SOC
      ARM: dts: rockchip: add rockchip RK1108 Evaluation board

Heiko Stuebner (1):
      Merge branch 'v4.10-shared/clkids' into v4.10-armsoc/dts32

Jacob Chen (1):
      ARM: dts: rockchip: add the sdmmc pinctrl for rk1108

Pawe? Jarosz (2):
      ARM: dts: rockchip: fix TSADC reset node for rk3066a
      ARM: dts: rockchip: enable dma for uart and mmc on rk3066a

Shawn Lin (2):
      dt-bindings: rockchip-dw-mshc: add RK1108 dw-mshc description
      clk: rockchip: add dt-binding header for rk1108

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk1108-evb.dts                   |  69 ++++
 arch/arm/boot/dts/rk1108.dtsi                      | 452 +++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  19 +-
 include/dt-bindings/clock/rk1108-cru.h             | 269 ++++++++++++
 6 files changed, 810 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk1108-evb.dts
 create mode 100644 arch/arm/boot/dts/rk1108.dtsi
 create mode 100644 include/dt-bindings/clock/rk1108-cru.h
