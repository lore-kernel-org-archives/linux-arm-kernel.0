From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 12 Jul 2018 21:12:42 +0000
Subject: [PATCH v3 0/2] clk: meson: add a sub EMMC clock controller support
Message-ID: <20180712211244.11428-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will add a MMC clock controller driver support.
The original idea about adding a clock controller is during the
discussion in the NAND driver mainline effort[1].

I've tested this in the S400 board (AXG platform) by using NAND driver.

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


Yixun Lan (2):
  clk: meson: add DT documentation for emmc clock controller
  clk: meson: add sub MMC clock controller driver

 .../bindings/clock/amlogic,mmc-clkc.txt       |  31 ++
 drivers/clk/meson/Kconfig                     |   9 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/mmc-clkc.c                  | 367 ++++++++++++++++++
 .../clock/amlogic,meson-mmc-clkc.h            |  16 +
 5 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
 create mode 100644 drivers/clk/meson/mmc-clkc.c
 create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h

-- 
2.18.0
