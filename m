From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed,  7 Oct 2015 11:08:55 +0200
Subject: [PATCH v4 0/4] ST PLL improvement
Message-ID: <1444208939-10233-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
 - Spinlock affectation was removed unintentionally in clkgen_pll_register()
   since v3

Changes in v3:
 - reorganize patch 1 and 2 to avoid a break git bisect

Changes in v2:
 - Add const for st_pll4600c28_418_a9 structure
 - Use readl_relaxed_poll_timeout macro instead Jiffies
 - Add patch to enable stih418 A9 pll via DT.

This patchset is based on '[PATCH 0/2] ST PLL fixes for 4.3'

Gabriel Fernandez (4):
  drivers: clk: st: Support for enable/disable in Clockgen PLLs
  drivers: clk: st: PLL rate change implementation for DVFS
  drivers: clk: st: Correct the pll-type for A9 for stih418
  ARM: STi: DT: Add support for stih418 A9 pll

 .../devicetree/bindings/clock/st/st,clkgen-pll.txt |   1 +
 arch/arm/boot/dts/stih418-clock.dtsi               |   2 +-
 drivers/clk/st/clkgen-mux.c                        |   3 +
 drivers/clk/st/clkgen-pll.c                        | 469 ++++++++++++++++++++-
 drivers/clk/st/clkgen.h                            |   2 +
 5 files changed, 468 insertions(+), 9 deletions(-)

-- 
1.9.1
