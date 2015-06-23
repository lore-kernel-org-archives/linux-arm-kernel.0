From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:18 +0200
Subject: [PATCH 0/9] clk: ST clock fixes
Message-ID: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This first patch-set contains various clock fixes for ST SoC.

Gabriel Fernandez (7):
  drivers: clk: st: Incorrect clocks status
  drivers: clk: st: Incorrect register offset used for lock_status
  drivers: clk: st: Remove unused code
  drivers: clk: st: Fix FSYN channel values
  drivers: clk: st: Fix mux bit-setting for Cortex A9 clocks
  drivers: clk: st: Rename st_pll3200c32_407_c0_x into
    st_pll3200c32_cx_x
  ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x

Giuseppe Cavallaro (1):
  drivers: clk: st: Fix flexgen lock init

Pankaj Dev (1):
  drivers: clk: st: Add CLK_GET_RATE_NOCACHE flag to clocks

 .../devicetree/bindings/clock/st/st,clkgen-pll.txt |  4 ++--
 arch/arm/boot/dts/stih407-clock.dtsi               |  4 ++--
 arch/arm/boot/dts/stih410-clock.dtsi               |  4 ++--
 arch/arm/boot/dts/stih418-clock.dtsi               |  4 ++--
 drivers/clk/st/clk-flexgen.c                       |  4 +++-
 drivers/clk/st/clkgen-fsyn.c                       | 20 +++++++----------
 drivers/clk/st/clkgen-mux.c                        | 25 +++++++++++++---------
 drivers/clk/st/clkgen-pll.c                        | 14 ++++++------
 8 files changed, 41 insertions(+), 38 deletions(-)

-- 
1.9.1
