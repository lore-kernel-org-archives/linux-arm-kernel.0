From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Thu,  9 Jul 2015 13:57:37 +0200
Subject: [PATCH 0/3] ST PLL improvement
Message-ID: <1436443060-12866-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds:
 * Enable/Disable support for Clockgen PLLs.
 * A new a9 pll for stih418 platform.
 * PLL rate change implementation for DVFS


Gabriel Fernandez (3):
  drivers: clk: st: Support for enable/disable in Clockgen PLLs
  drivers: clk: st: PLL rate change implementation for DVFS
  drivers: clk: st: Correct the pll-type for A9 for stih418

 .../devicetree/bindings/clock/st/st,clkgen-pll.txt |   1 +
 drivers/clk/st/clkgen-mux.c                        |   3 +
 drivers/clk/st/clkgen-pll.c                        | 470 ++++++++++++++++++++-
 drivers/clk/st/clkgen.h                            |   2 +
 4 files changed, 468 insertions(+), 8 deletions(-)

-- 
1.9.1
