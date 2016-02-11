From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 11 Feb 2016 16:12:35 +0100
Subject: [GIT PULL 4/4] rockchip dts32 changes for 4.6
In-Reply-To: <1734524.3yNt5L3F1F@phil>
References: <1734524.3yNt5L3F1F@phil>
Message-ID: <22050679.RDDVtpO0ps@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

and finally this is the biggest set ... 32bit devicetree changes.
For the clock-ids this includes a shared branch that gets shared
with the clock-branch sent to the clock-maintainers.

As the tag describes, contents are pretty diverse but simple changes.


Thanks
Heiko


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.6-rockchip-dts32-1

for you to fetch changes up to 741d3b0c1f6187dbf9b509b6776c77828d4c66d5:

  ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard matrix (2016-02-10 22:41:53 +0100)

----------------------------------------------------------------
Assorted bunch of 32bit Rockchip devicetree changes. More clocks,
nodes and fixes like the increased drive-strength on the firefly.
Most interesting is maybe the enablement of the pl330 option
for handling the broken flushp operation that is present on the
current Rockchip SoCs. Together with the driver-side enablement
this should give us working dma finally.

----------------------------------------------------------------
Addy Ke (1):
      ARM: dts: rockchip: Add arm, pl330-broken-no-flushp quirk for rk3288 platform

Andy Yan (2):
      ARM: dts: rockchip: enable pwm3 as pwm regulator for rk3066a based boards
      ARM: dts: rockchip: increase vdd_arm voltage for rk3066a based boards

Caesar Wang (11):
      ARM: dts: rockchip: set the pinctrl default setting for rk3036 i2s
      ARM: dts: rockchip: add the sound setup for rk3036-kylin board
      ARM: dts: rockchip: enable the uart0 for kylin board
      ARM: dts: rockchip: enable the high speed on sdio for kylin board
      ARM: dts: rockchip: add the sdio power sequence for kylin board
      ARM: dts: rockchip: add the sdmmc for kylin board
      ARM: dts: rockchip: add soc-specific compatibles for rk3036 SoCs
      ARM: dts: rockchip: add the leds control for rk3036-kylin board
      ARM: dts: rockchip: add mclk for rt5616 on rk3036 kylin board
      ARM: dts: rockchip: support the spi for rk3036
      ARM: dts: rockchip: add arm,pl330-broken-no-flushp quirk for rk3036 SoCs

Chris Zhong (1):
      ARM: dts: rockchip: add rk3288 mipi_dsi nodes

Heiko Stuebner (3):
      ARM: dts: rockchip: swap i2s clock ordering on rk3036
      ARM: dts: rockchip: add clock-cells for usb phy nodes
      Merge branch 'v4.6-shared/clkids' into v4.6-armsoc/dts32

James Chao (1):
      ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard matrix

Pawe? Jarosz (2):
      clk: rockchip: Add new id for rk3066 tsadc clock
      ARM: dts: rockchip: add tsadc node

Romain Perier (1):
      ARM: dts: rockchip: Add LEDs via gpio-leds for Radxa Rock2 Square

Shawn Lin (3):
      dt-bindings: rockchip-dw-mshc: add RK3368 dw-mshc description
      dt-bindings: rockchip-dw-mshc: add RK3036 dw-mshc description
      ARM: dts: rockchip: Add arm, pl330-broken-no-flushp quirk for rk3xxx platform

Sjoerd Simons (3):
      ARM: dts: rockchip: Add the iodomains for the Rock2 SOM
      ARM: dts: rockchip: Add the SDIO wifi on Radxa Rock2 square
      ARM: dts: rockchip: Assign RK3288 EDP_24M input centrally

Sudeep Holla (1):
      ARM: dts: rockchip: replace gpio-key,wakeup with wakeup-source property

Wadim Egorov (1):
      ARM: dts: rockchip: Bump sd card pin drive strength up on firefly boards

Xing Zheng (1):
      ARM: dts: rockchip: increase the mclk_fs to 512 for kylin board

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   2 +
 arch/arm/boot/dts/cros-ec-keyboard.dtsi            |   1 +
 arch/arm/boot/dts/rk3036-kylin.dts                 | 104 +++++++++++++++++++++
 arch/arm/boot/dts/rk3036.dtsi                      |  69 +++++++++++---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |  19 +++-
 arch/arm/boot/dts/rk3066a-marsboard.dts            |  16 ++++
 arch/arm/boot/dts/rk3066a-rayeager.dts             |  18 +++-
 arch/arm/boot/dts/rk3066a.dtsi                     |  24 ++++-
 arch/arm/boot/dts/rk3188-radxarock.dts             |   2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   2 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  26 +++++-
 arch/arm/boot/dts/rk3288-popmetal.dts              |   2 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |   2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |  26 ++++++
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  48 +++++++++-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    |   2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   7 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  48 ++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi                      |   3 +
 include/dt-bindings/clock/rk3188-cru-common.h      |   1 +
 21 files changed, 389 insertions(+), 35 deletions(-)
