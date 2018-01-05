From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 5 Jan 2018 17:56:15 +0800
Subject: [PATCH 0/6] ARM64: dts: meson-axg: UART DT updates
Message-ID: <20180105095621.196472-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Kevin
 These are the UART DT updates for the Meson-AXG platform.

The patch 1, 2 are two general fixes.
Other patches are about adding clock & pinctrl info, then using them.
Last patch enable UART_A which connect to BT module in the S400 board.

Note: 
This series depend on previous UART_AO clock switch patch[1]
also, these patch request clocks, so they need the
tag:meson-clk-for-v4.16-2 from clk-meson's tree in order to compile.

[1] 
http://lkml.kernel.org/r/20171215141741.175985-1-yixun.lan at amlogic.com

Yixun Lan (6):
  ARM64: dts: meson-axg: uart: drop legacy compatible name from EE UART
  ARM64: dts: meson-axg: uart: fix address space range
  ARM64: dts: meson-axg: uart: Add the clock info description
  ARM64: dts: meson-axg: uart: Add the pinctrl info description
  arm64: dts: meson-axg: complete the pinctrl info for UART_AO_A
  ARM64: dts: meson-axg: enable the UART_A controller

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |   9 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 108 ++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 4 deletions(-)

-- 
2.15.1
