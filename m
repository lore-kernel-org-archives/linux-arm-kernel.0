From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 Aug 2017 10:42:12 +0200
Subject: [GIT PULL 2/2] second round of Rockchip dts32 changes for 4.14
In-Reply-To: <4088347.CX4PhsiguF@phil>
References: <4088347.CX4PhsiguF@phil>
Message-ID: <2301603.fd1AhSc3fO@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0f4dc7e154d054303c4dd6b5c3e3207f9a7f8714:

  ARM: dts: rockchip: fix property-ordering in rv1108 mmc nodes (2017-07-22 22:41:35 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts32-2

for you to fetch changes up to 274ff50d3ad951bca0adbfb9ffd628d35ba6db6f:

  ARM: dts: rockchip: enable usb for rv1108-evb (2017-08-23 09:24:51 +0200)

----------------------------------------------------------------
A lot of attention for the rv1108 soc targetted at media-processing
(usb, operating points, spi, pwm, adc, watchdog, i2c and devices for
its evb).

RK3228/3229 gets iommu and spi nodes. Similar to the rk3288 which
also gets some more iommu nodes as well as getting converted to 64
bit addresses due to wanting to address more than 4GB of memory
via LPAE.

----------------------------------------------------------------
Andy Yan (10):
      ARM: dts: rockchip: add i2c dt nodes for rv1108
      ARM: dts: rockchip: add watchdog dt node for rv1108
      ARM: dts: rockchip: add saradc support for rv1108
      ARM: dts: rockchip: add spi dt node for rv1108
      ARM: dts: rockchip: add pwm dt nodes for rv1108
      ARM: dts: rockchip: add pwm backlight for rv1108 evb
      ARM: dts: rockchip: add pmic rk805 dt node for rv1108 evb
      ARM: dts: rockchip: add accelerometer bma250e dt node for rv1108 evb
      ARM: dts: rockchip: add cpu opp table for rv1108
      ARM: dts: rockchip: add cpu power supply for rv1108 evb

Elaine Zhang (3):
      clk: rockchip: add more clk ids for rv1108
      clk: rockchip: rename the clk id for HCLK_I2S1_2CH
      clk: rockchip: fix up indentation of some RV1108 clock-ids

Frank Wang (3):
      dt-bindings: update grf-binding for rv1108 SoCs
      ARM: dts: rockchip: add usb nodes for rv1108 SoCs
      ARM: dts: rockchip: enable usb for rv1108-evb

Heiko Stuebner (1):
      Merge branch 'v4.14-shared/clkids' into v4.14-armsoc/dts32

Huibin Hong (1):
      ARM: dts: rockchip: add spi node and spi pinctrl on rk3228/rk3229

Simon Xue (2):
      ARM: dts: rockchip: add more iommu nodes on rk3288
      ARM: dts: rockchip: add rk322x iommu nodes

Tao Huang (1):
      ARM: dts: rockchip: convert rk3288 device tree files to 64 bits

 .../devicetree/bindings/soc/rockchip/grf.txt       |   3 +
 arch/arm/boot/dts/rk322x.dtsi                      |  86 +++++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +-
 arch/arm/boot/dts/rk3288-fennec.dts                |   2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  |   2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   2 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  |   2 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi          |   2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts              |   2 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |   2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   2 +-
 arch/arm/boot/dts/rk3288-tinker.dts                |   2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   2 +-
 arch/arm/boot/dts/rk3288.dtsi                      | 215 +++++++------
 arch/arm/boot/dts/rv1108-evb.dts                   | 186 +++++++++++
 arch/arm/boot/dts/rv1108.dtsi                      | 349 ++++++++++++++++++++-
 include/dt-bindings/clock/rv1108-cru.h             | 123 +++++++-
 17 files changed, 867 insertions(+), 117 deletions(-)
