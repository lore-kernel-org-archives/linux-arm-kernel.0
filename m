From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 13 Jun 2013 16:58:36 +0200
Subject: [PATCH v4 0/4] arm: add basic support for Rockchip Cortex-A9 SoCs
Message-ID: <201306131658.36584.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fourth version of basic Rockchip A9 support.

Changes since v3:
- split out standalone dw_mmc patches (submitted to linux-mmc)
- Remove divider and mux clocks and use fixed rate clocks instead until
  divider and mux clocks have got their generic dt bindings
- Make the gate clock use CLK_OF_DECLARE and document the bindings

Changes since v2:
- use common (pending review) HIWORD_MASK clock flag from Haojian Zhuang and me
- pinctrl driver is already in the pinctrl tree
- add core-periph clock that supplies the twd
- split "mmc: dw_mmc-pltfm: add Rockchip variant" into move and feature parts
  as suggested by Andy Shevchenko

Changes since v1:
- addressed Linus Walleij's comments to the pinctrl driver, including the
  move to generic pinconfig (hopefully I did catch all)
- renamed the clocks to use the SoC name of the initial user
  as suggested by Olof Johansson
- fixed the uart address, found by Arnd Bergmann
- address Arnd's comments on the board file (use of_clk_init and friends,
  remove map_io, use real soc names)
- removed Makefile.boot as suggested by Thomas Petazzoni


Dependencies:
- the 3 clock changes of "support Hisilicon SoC" from Haojian Zhuang (HIWORD_MASK)
- series "dw_apb_timer: osc as sched_clock, clocks and clocksource_of support"
  which is in arm-soc already

Heiko Stuebner (4):
  clk: add support for Rockchip gate clocks
  arm: Add basic clocks for Rockchip rk3066a SoCs
  arm: add debug uarts for rockchip rk29xx and rk3xxx series
  arm: add basic support for Rockchip RK3066a boards

 .../devicetree/bindings/clock/rockchip.txt         |   74 ++++
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |   34 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/rk3066a-clocks.dtsi              |  300 +++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  390 ++++++++++++++++++++
 arch/arm/include/debug/rockchip.S                  |   42 +++
 arch/arm/mach-rockchip/Kconfig                     |   16 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/rockchip.c                  |   54 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/rockchip/Makefile                      |    5 +
 drivers/clk/rockchip/clk-rockchip.c                |   94 +++++
 13 files changed, 1014 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip.txt
 create mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/rk3066a.dtsi
 create mode 100644 arch/arm/include/debug/rockchip.S
 create mode 100644 arch/arm/mach-rockchip/Kconfig
 create mode 100644 arch/arm/mach-rockchip/Makefile
 create mode 100644 arch/arm/mach-rockchip/rockchip.c
 create mode 100644 drivers/clk/rockchip/Makefile
 create mode 100644 drivers/clk/rockchip/clk-rockchip.c

-- 
1.7.10.4
