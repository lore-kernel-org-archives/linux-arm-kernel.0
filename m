From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  3 Mar 2015 10:21:57 +0800
Subject: [PATCH 0/3] ARM: sun9i: Add support for PRCM on Allwinner A80 SoC
Message-ID: <1425349320-2754-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Some time ago I sent out an RFC series, which was not merged due
to lack of matching documentation for the SoC. A few weeks back I
sent out a request for the documents again. I have not received a
response. So I'm sending out the series now.

This series adds support for the Power Reset and Clock Management
module on Allwinner's A80 SoC. The PRCM manages clocks and resets
for the "special" block of peripherals, or the R/RTC block in
earlier SoCs. These peripherals include a standby processor core,
a timer block, a watchdog, pin controller, 1 wire interface, PS/2
interface, a UART, the RSB controller, a DMA controller, a consumer
IR receiver block, 2 I2C controllers, and 2 I2S controllers. We do
not have documents for all the peripherals. Support will be added
where possible.


Patch 1 adds support for the apbs (apb0 in earlier SoCs) gates.

Patch 2 adds sun9i-a80 support to the PRCM mfd driver

Patch 3 adds the clock and reset nodes for the PRCM to the A80 DTSI.


To Allwinner people:
If you have any related documents or comments, please send them out.


Regards,
ChenYu


Chen-Yu Tsai (3):
  clk: sunxi: sun6i-apb0: Add support for sun9i A80 apbs gates
  mfd: sun6i-prcm: Add support for PRCM found on Allwinner A80 SoC
  ARM: dts: sun9i: Add A80 PRCM clocks and reset control nodes

 Documentation/devicetree/bindings/clock/sunxi.txt  |  1 +
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  3 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   | 54 +++++++++++++++++++-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c           |  6 +++
 drivers/mfd/sun6i-prcm.c                           | 58 ++++++++++++++++++++++
 5 files changed, 120 insertions(+), 2 deletions(-)

-- 
2.1.4
