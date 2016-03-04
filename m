From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 04 Mar 2016 02:42:20 +0100
Subject: [GIT PULL 2/3] 2nd part of rockchip dts32 changes for 4.6
In-Reply-To: <2165258.7vUftGQ1I7@diego>
References: <2165258.7vUftGQ1I7@diego>
Message-ID: <7756954.yF1An993JL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

a bunch of device nodes for newly enabled drivers and some non-urgent
small fixes.
So if possible, please pull

Thanks
Heiko


The following changes since commit 741d3b0c1f6187dbf9b509b6776c77828d4c66d5:

  ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard matrix (2016-02-10 22:41:53 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.6-rockchip-dts32-2

for you to fetch changes up to a1dab1ca16d447cd5a60cc704c406846f9a815c9:

  ARM: dts: rockchip: remove broken-cd from emmc and sdio (2016-03-02 22:42:58 +0100)

----------------------------------------------------------------
A lot nodes for newly supported devices on rk3036, rk3228 and rk3288.

----------------------------------------------------------------
Caesar Wang (6):
      ARM: dts: rockchip: add vop device node for rk3036
      ARM: dts: rockchip: add hdmi device node for rk3036
      ARM: dts: rockchip: enable graphics support on rk3036-kylin
      clk: rockchip: add id of the tsadc clock found on rk3228 SoCs
      ARM: dts: rockchip: add the thermal main info found on rk3228
      ARM: dts: rockchip: enable the tsadc for rk3228 evb

Heiko Stuebner (1):
      Merge branch 'v4.6-shared/clkids' into v4.6-armsoc/dts32

Jianqun Xu (1):
      dt-bindings: add bindings for Rockchip grf

John Keeping (3):
      ARM: dts: rockchip: fix MIPI interrupt on rk3288
      ARM: dts: rockchip: fix audio interrupts on rk3288
      ARM: dts: rockchip: add mipi_dsi to VIO power domain on rk3288

Shawn Lin (1):
      ARM: dts: rockchip: remove broken-cd from emmc and sdio

Yakir Yang (2):
      clk: rockchip: add the new clock ids for RK3228 VOP
      clk: rockchip: add the new clock ids for RK3228 HDMI

 .../devicetree/bindings/soc/rockchip/grf.txt       | 35 +++++++++++
 arch/arm/boot/dts/rk3036-kylin.dts                 | 13 +++-
 arch/arm/boot/dts/rk3036.dtsi                      | 66 ++++++++++++++++++++-
 arch/arm/boot/dts/rk3066a-rayeager.dts             |  2 -
 arch/arm/boot/dts/rk3228-evb.dts                   |  8 ++-
 arch/arm/boot/dts/rk3228.dtsi                      | 69 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  1 -
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  2 -
 arch/arm/boot/dts/rk3288-popmetal.dts              |  1 -
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  2 -
 arch/arm/boot/dts/rk3288.dtsi                      |  7 ++-
 include/dt-bindings/clock/rk3228-cru.h             | 12 ++++
 12 files changed, 204 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
