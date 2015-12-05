From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 05 Dec 2015 01:56:23 +0100
Subject: [GIT PULL 2/3] rockchip dts32 changes for 4.5
In-Reply-To: <1936935.FVZdWRYuBf@diego>
References: <1936935.FVZdWRYuBf@diego>
Message-ID: <18120528.xr1opvZF1r@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below 32bit arm dts changes for Rockchip. As the tag describes,
new boards, a new soc and some smaller stuff.

It includes a shared branch containing dt-binding header changes for new
clock-ids and gets shared with the clock changes implementing these.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.5-rockchip-dts32-1

for you to fetch changes up to 066111411101f6b020af1a7c752859a12476ba21:

  ARM: dts: rockchip: add gpio-ir-receiver to the R89 board (2015-12-04 20:01:27 +0100)

----------------------------------------------------------------
First round of arm devicetree changes.
Among the bigger changes are two new Veyron boards, support for
the dual-core cortex-a7 rk3036 soc and addition of support for
the crypto engine of the rk3288. Smaller changes include some
IR receivers, updates of thermal settings more reflecting real-
life and testing-results.

----------------------------------------------------------------
Caesar Wang (1):
      ARM: dts: rockchip: update the thermal management on rk3288

Chris Zhong (1):
      ARM: dts: rockchip: add veyron-mickey board

Heiko Stuebner (7):
      ARM: dts: rockchip: Setup rk3066/rk3188 ethernet0 alias for u-boot
      Merge branch 'v4.5-clk/clkids' into v4.5-armsoc/dts32
      ARM: dts: rockchip: override thermal settings on veyron-speedy
      ARM: dts: rockchip: make sure edp_24m is associated to xin24m on veyron
      ARM: dts: rockchip: add veyron-brain board
      ARM: dts: rockchip: add touchscreen node to veyron minnie
      ARM: dts: rockchip: add gpio-ir-receiver to the R89 board

John Keeping (1):
      ARM: dts: rockchip: set system-power-controller property on rk3288-rock2

Sjoerd Simons (2):
      ARM: dts: rockchip: Setup rk3288 ethernet0 alias for u-boot
      ARM: dts: rockchip: Add IR receiver to RK3288 Radxa Rock 2 Square

Sugar Zhang (1):
      ARM: dts: rockchip: add channels properties for i2s

Xing Zheng (3):
      clk: rockchip: add dt-binding header for rk3036
      ARM: dts: rockchip: add core rk3036 dtsi
      ARM: dts: rockchip: add rk3036-evb board

Zain Wang (2):
      clk: rockchip: add an id for rk3288 crypto clk
      ARM: dts: rockchip: Add Crypto node for rk3288

 Documentation/devicetree/bindings/arm/rockchip.txt |  14 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/rk3036-evb.dts                   |  64 +++
 arch/arm/boot/dts/rk3036.dtsi                      | 554 +++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     |   6 +
 arch/arm/boot/dts/rk3188.dtsi                      |   2 +
 arch/arm/boot/dts/rk3288-r89.dts                   |  13 +
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   1 +
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  13 +
 arch/arm/boot/dts/rk3288-thermal.dtsi              |  14 +-
 arch/arm/boot/dts/rk3288-veyron-brain.dts          | 139 ++++++
 arch/arm/boot/dts/rk3288-veyron-mickey.dts         | 250 ++++++++++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts         |  12 +
 arch/arm/boot/dts/rk3288-veyron-speedy.dts         |   8 +
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   5 +
 arch/arm/boot/dts/rk3288.dtsi                      |  15 +
 arch/arm/boot/dts/rk3xxx.dtsi                      |   1 +
 include/dt-bindings/clock/rk3036-cru.h             | 193 +++++++
 include/dt-bindings/clock/rk3288-cru.h             |   1 +
 19 files changed, 1306 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3036-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3036.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-brain.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-mickey.dts
 create mode 100644 include/dt-bindings/clock/rk3036-cru.h
