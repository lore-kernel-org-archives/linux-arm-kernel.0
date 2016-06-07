From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Jun 2016 12:19:24 +0100
Subject: [PATCH 0/6] clk: sti: Add support for critical clocks
Message-ID: <20160607111930.10375-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the platform's critical clocks in DT, then search for them
from the framework.  This set allows us to remove the clk_ignore_unused
kernel command line flag which has been required to achieve a successful
boot to prompt until this point.

This may not be the definitive list.  There may be other clocks which
need to be marked as critical, but we can add those as we go along.

Lee Jones (6):
  clk: st: clk-flexgen: Detect critical clocks
  clk: st: clkgen-fsyn: Detect critical clocks
  clk: st: clkgen-pll: Detect critical clocks
  ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
  ARM: sti: stih410-clocks: Identify critical clocks
  spi: st-ssc4: Remove 'no clocking' hack

 arch/arm/boot/dts/stih410-clock.dtsi     |  9 ++++++++
 drivers/clk/st/clk-flexgen.c             |  4 +++-
 drivers/clk/st/clkgen-fsyn.c             | 10 ++++++---
 drivers/clk/st/clkgen-pll.c              | 27 +++++++++++++++---------
 drivers/spi/spi-st-ssc4.c                | 36 +++++---------------------------
 include/dt-bindings/clock/stih407-clks.h |  4 ++++
 6 files changed, 45 insertions(+), 45 deletions(-)

-- 
2.8.3
