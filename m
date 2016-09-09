From: bd-phuc@jinso.co.jp (bd-phuc at jinso.co.jp)
Date: Fri,  9 Sep 2016 20:43:06 +0900
Subject: [PATCH 0/8] clocksource: sh_cmt: Add R-car Gen3 CMT0/1 support
Message-ID: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bui Duc Phuc <bd-phuc@jinso.co.jp>

Hi,

These are my first patches which will be added CMT driver for support 
R-car Gen3 series (r8a7795 and r8a7796).
Please consider these patches.

Best regards.

Bui Duc Phuc (8):
  devicetree: binding: R-car Gen3 CMT0 and CMT1 bindings
  ARM64: dts: r8a7795: Add CMT device to DT
  ARM64: dts: r8a7796: Add CMT device to DT
  clk: renesas: r8a7795: Add CMT clocks
  clk: renesas: r8a7796: Add CMT clocks
  clocksource: sh_cmt: Support separate R-car Gen3 CMT0/1
  clocksource: Kconfig: Modify CMT config support 64bit
  ARM64: defconfig: Enable SH_TIMER_CMT config option

 .../devicetree/bindings/timer/renesas,cmt.txt      |  2 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 30 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 30 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |  4 +++
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |  4 +++
 drivers/clocksource/Kconfig                        |  2 +-
 drivers/clocksource/sh_cmt.c                       | 21 +++++++++++++--
 8 files changed, 91 insertions(+), 3 deletions(-)

-- 
2.7.4
