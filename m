From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Fri, 2 Nov 2018 00:30:52 +0800
Subject: [PATCH v6 0/3] clk: meson: add a sub EMMC clock controller support
Message-ID: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will add a MMC clock controller driver support.
The original idea about adding a clock controller is during the
discussion in the NAND driver mainline effort[1].

This driver is tested in the S400 board (AXG platform) with NAND driver.

Changes since v5 [6]:
 - remove divider ops with .init and use sclk_div instead
 - drop CLK_DIVIDER_ROUND_CLOSEST in mux and div
 - drop the useless type cast 

Changes since v4 [5]:
 - use struct parm in phase delay driver
 - remove 0 delay releted part in phase delay driver
 - don't rebuild the parent name once again
 - add divider ops with .init

Changes since v3 [4]:
 - separate clk-phase-delay driver
 - replace clk_get_rate() with clk_hw_get_rate()
 - collect Rob's R-Y
 - drop 'meson-' prefix from compatible string

 Changes since v2 [3]:
 - squash dt-binding clock-id patch
 - update license
 - fix alignment
 - construct a clk register helper() function

Changes since v1 [2]:
 - implement phase clock
 - update compatible name
 - adjust file name
 - divider probe() into small functions, and re-use them

[1] https://lkml.kernel.org/r/20180628090034.0637a062 at xps13
[2] https://lkml.kernel.org/r/20180703145716.31860-1-yixun.lan at amlogic.com
[3] https://lkml.kernel.org/r/20180710163658.6175-1-yixun.lan at amlogic.com
[4] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan at amlogic.com
[5] https://lkml.kernel.org/r/20180809070724.11935-4-yixun.lan at amlogic.com
[6] https://lkml.kernel.org/r/1539839245-13793-1-git-send-email-jianxin.pan at amlogic.com
Yixun Lan (3):
  clk: meson: add emmc sub clock phase delay driver
  clk: meson: add DT documentation for emmc clock controller
  clk: meson: add sub MMC clock controller driver

 .../devicetree/bindings/clock/amlogic,mmc-clkc.txt |  39 +++
 drivers/clk/meson/Kconfig                          |  10 +
 drivers/clk/meson/Makefile                         |   3 +-
 drivers/clk/meson/clk-phase-delay.c                |  75 +++++
 drivers/clk/meson/clk-regmap.c                     |   1 -
 drivers/clk/meson/clk-regmap.h                     |   1 +
 drivers/clk/meson/clkc.h                           |  13 +
 drivers/clk/meson/mmc-clkc.c                       | 310 +++++++++++++++++++++
 include/dt-bindings/clock/amlogic,mmc-clkc.h       |  17 ++
 9 files changed, 467 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
 create mode 100644 drivers/clk/meson/clk-phase-delay.c
 create mode 100644 drivers/clk/meson/mmc-clkc.c
 create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h

-- 
1.9.1
