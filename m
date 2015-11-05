From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu,  5 Nov 2015 15:33:54 +0800
Subject: [PATCH v7 0/6] Build and support rk3036 SoC platform
Message-ID: <1446708840-12038-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  We need to support rk3036 soc platform via upstream, there are
some primary parts for the initial release of minimum system: dts,
clk-pll, smp, and clock tree for rk3036, and additional, we can use
these startup and run to init processs.

Thanks.

Changed in v7:
- removed the patch "make sure timer5 is enabled on rk3036 platforms" (applied)
- removed the patch "add support smp for rk3036" (applied)

Changed in v6:
- add hardware timer in dtsi and some the aliases of basic modules

Changed in v5:
- don't use clk_ APIs in the pll init-callback

Changed in v4:
- add some basic IP modules on rk3036.dtsi
- optimized supporting smp codes

Changed in v3:
- optimized some codes based on v2
- removed the patch "initial set time for rtc-hym8563" (useless)
- removed the patch "pinctrl" (approved)

Changed in v2:
- based on v1, add clock controller documentation
- enable timer5 startup
- add smp for cpu1
- initial set time for rtc-hym8563

Changes in v1:
- add dts, pinctrl and clock tree for rk3036 soc platform

The patchset (6):
6) ARM: dts: enable smp for rk3036
5) ARM: dts: rockchip: add core rk3036 dts
4) clk: rockchip: add clock controller for rk3036
3) clk: rockchip: add new pll-type for rk3036 and similar socs
2) clk: rockchip: add dt-binding header for rk3036
1) dt-bindings: add documentation of rk3036 clock controller


Changes in v7:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Xing Zheng (6):
  dt-bindings: add documentation of rk3036 clock controller
  clk: rockchip: add dt-binding header for rk3036
  clk: rockchip: add new pll-type for rk3036 and similar socs
  clk: rockchip: add clock controller for rk3036
  ARM: dts: rockchip: add core rk3036 dts
  ARM: dts: enable smp for rk3036

 .../bindings/clock/rockchip,rk3036-cru.txt         |   56 ++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/rk3036-evb.dts                   |   64 +++
 arch/arm/boot/dts/rk3036.dtsi                      |  552 ++++++++++++++++++++
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-pll.c                     |  249 ++++++++-
 drivers/clk/rockchip/clk-rk3036.c                  |  478 +++++++++++++++++
 drivers/clk/rockchip/clk.h                         |   32 +-
 include/dt-bindings/clock/rk3036-cru.h             |  193 +++++++
 9 files changed, 1624 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
 create mode 100644 arch/arm/boot/dts/rk3036-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3036.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk3036.c
 create mode 100644 include/dt-bindings/clock/rk3036-cru.h

-- 
1.7.9.5
