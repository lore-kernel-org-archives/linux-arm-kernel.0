From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 1 Dec 2017 09:24:48 +0800
Subject: [PATCH v4 0/4] add clk controller driver for Meson-AXG SoC
Message-ID: <20171201012452.27086-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for the clk controller which found in Meson AXG SoC

  Note, we deliberately create a seperate source file for the Meson AXG
series, instead of sharing code with previous GXBB/GXL - the file axg.c
It would help us maintaining the code more easily.

Changes since v3 [3]:
 - separate dt-bindings header file
 - adjust license note as standard way
 - replace of_iomap with platform/devm API
 - add Rob's Ack to Patch 1,4

Changes since v2 [2]:
 - drop register offset calculation
 - update dt-bindings for new compatible variant

Changes since v1 [1]:
 - rework register definion, use '(offset << 2)' to better match
   the description from data sheet
 - drop "#include dt-bindings/clock/gxbb-aoclkc.h" from dts
 - rebase code to v4.15-rc1

[3]
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005487.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005488.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005489.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005490.html

[2]
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005468.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005469.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005470.html

[1] 
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005239.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005240.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005241.html



Qiufang Dai (3):
  clk: meson-axg: add clocks dt-bindings required header
  clk: meson-axg: add clock controller drivers
  arm64: dts: meson-axg: add clock DT info for Meson AXG SoC

Yixun Lan (1):
  dt-bindings: clock: add compatible variant for the Meson-AXG

 .../bindings/clock/amlogic,gxbb-clkc.txt           |   7 +-
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  15 +
 drivers/clk/meson/Kconfig                          |   8 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/axg.c                            | 944 +++++++++++++++++++++
 drivers/clk/meson/axg.h                            | 126 +++
 include/dt-bindings/clock/axg-clkc.h               |  71 ++
 8 files changed, 1171 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/meson/axg.c
 create mode 100644 drivers/clk/meson/axg.h
 create mode 100644 include/dt-bindings/clock/axg-clkc.h

-- 
2.15.0
