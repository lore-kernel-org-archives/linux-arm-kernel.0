From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Aug 2017 13:20:21 +0200
Subject: [RFC 0/4] arm64: Realtek RTD1295 clocks
Message-ID: <20170817112026.24062-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds two clock controllers for the Realtek RTD1295 SoC.
Based on my reset controller and IRQ mux series.

There being no public source code for RTD1295, the implementation is based on
register offsets, fields and names seen in the vendor DT, unified into 2 nodes.

The PLL calculations were experimentally found by comparing vendor Android
/sys/kernel/debug/clk/clk_summary to the register field values in /dev/mem -
thus the formulas may be incomplete or incorrect.

Together with the reset driver and IRQ mux, the clock gates allow to
initialize UART1.

Code needs cleanups - sharing this for calculation findings and design.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Cc: Roc He <hepeng@zidoo.tv>
Cc: ??? <jiang.liqin@geniatech.com>
Cc: devicetree at vger.kernel.org

Andreas F?rber (4):
  dt-bindings: clock: Add Realtek RTD1295
  arm64: dts: realtek: Add clock nodes for RTD1295
  clk: Add Realtek RTD1295
  arm64: dts: realtek: Update RTD1295 UART nodes with clocks

 .../devicetree/bindings/clock/realtek,rtd129x.txt  |  20 ++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  28 +-
 drivers/clk/Kconfig                                |   7 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-rtd1295.c                          | 385 +++++++++++++++++++++
 include/dt-bindings/clock/realtek,rtd1295.h        |  99 ++++++
 6 files changed, 537 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/realtek,rtd129x.txt
 create mode 100644 drivers/clk/clk-rtd1295.c
 create mode 100644 include/dt-bindings/clock/realtek,rtd1295.h

-- 
2.12.3
