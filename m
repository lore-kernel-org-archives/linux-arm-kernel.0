From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 26 Oct 2015 12:25:31 +0800
Subject: [PATCH v5 0/8] Build and support rk3036 SoC platform
Message-ID: <1445833539-6484-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  We need to support rk3036 soc platform via upstream, there are
3 primary parts for the initial release of minimum system: dts,
pinctrl, and clock tree for rk3036, and additional, we can use
these startup and run to init processs.

Thanks.

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

The patchset (8):
8) rockchip: make sure timer5 is enabled on rk3036 platforms
7) ARM: dts: enable smp for rk3036
6) ARM: rockchip: add support smp for rk3036
5) ARM: dts: rockchip: add core rk3036 dts
4) clk: rockchip: add new pll-type for rk3036 and similar socs
3) clk: rockchip: add clock controller for rk3036
2) clk: rockchip: add dt-binding header for rk3036
1) dt-bindings: add documentation of rk3036 clock controller


Changes in v5:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Heiko Stuebner (1):
  ARM: rockchip: add support smp for rk3036

Xing Zheng (7):
  dt-bindings: add documentation of rk3036 clock controller
  clk: rockchip: add dt-binding header for rk3036
  clk: rockchip: add clock controller for rk3036
  clk: rockchip: add new pll-type for rk3036 and similar socs
  ARM: dts: rockchip: add core rk3036 dts
  ARM: dts: enable smp for rk3036
  rockchip: make sure timer5 is enabled on rk3036 platforms

 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 .../bindings/clock/rockchip,rk3036-cru.txt         |   56 ++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/rk3036-evb.dts                   |   64 +++
 arch/arm/boot/dts/rk3036.dtsi                      |  541 ++++++++++++++++++++
 arch/arm/mach-rockchip/platsmp.c                   |   45 +-
 arch/arm/mach-rockchip/rockchip.c                  |   44 +-
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-pll.c                     |  249 ++++++++-
 drivers/clk/rockchip/clk-rk3036.c                  |  500 ++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |   30 ++
 include/dt-bindings/clock/rk3036-cru.h             |  195 +++++++
 12 files changed, 1697 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
 create mode 100644 arch/arm/boot/dts/rk3036-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3036.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk3036.c
 create mode 100644 include/dt-bindings/clock/rk3036-cru.h

-- 
1.7.9.5
