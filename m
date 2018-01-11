From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 11 Jan 2018 10:33:56 +0800
Subject: [PATCH v3 0/5] ARM64: dts: meson-axg: UART DT updates
Message-ID: <20180111023401.125658-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Kevin
 These are the UART DT updates for the Meson-AXG platform.

 The patch 1 is a general fix.
Other patches are about adding clock & pinctrl info, then using them.
Last patch enable UART_A which connect to a BT module on the S400 board.

Note: 
This series depend on previous UART_AO clock switch patch[1]
also, these patch request clocks, so they need the
tag:meson-clk-for-v4.16-2 from clk-meson's tree in order to compile.

Changes since v2 at [3]:
  -- add Jerome's Reviewed-by to patch 1
  -- adjust commit message, drop snip of code
  -- drop extra blank line

Changes since v1 at [2]:
  -- fix address range for all platform
  -- squash patch 1, 3 (drop compatible & add clock)
  -- fix typo in pinctrl info
  -- add Jerome's Ack

[3]
 http://lkml.kernel.org/r/20180106001044.108163-1-yixun.lan at amlogic.com

[2]
 http://lkml.kernel.org/r/20180105095621.196472-1-yixun.lan at amlogic.com

[1] 
 http://lkml.kernel.org/r/20171215141741.175985-1-yixun.lan at amlogic.com


Yixun Lan (5):
  ARM64: dts: meson: uart: fix address space range
  ARM64: dts: meson-axg: uart: drop legacy compatible name from EE UART
  ARM64: dts: meson-axg: uart: Add the pinctrl info description
  ARM64: dts: meson-axg: complete the pinctrl info for UART_AO_A
  ARM64: dts: meson-axg: enable the UART_A controller

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |   9 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 108 ++++++++++++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi      |  10 +--
 3 files changed, 118 insertions(+), 9 deletions(-)

-- 
2.15.1
