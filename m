From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 27 Nov 2017 17:48:42 +0800
Subject: [PATCH v2 0/2] add clk controller driver for Meson-AXG SoC
Message-ID: <20171127094844.16742-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for the clk controller which found in Meson AXG SoC

  Note, we deliberately create a seperate source file for the Meson AXG
series, instead of sharing code with previous GXBB/GXL - the file axg.c
It would help us maintaining the code more easily.

Changes since v1 [1]:
 - rework register definion, use '(offset << 2)' to better match
   the description from data sheet
 - drop "#include dt-bindings/clock/gxbb-aoclkc.h" from dts
 - rebase code to v4.15-rc1

[1] 
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005239.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005240.html
  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005241.html


Qiufang Dai (2):
  clk: meson-axg: add clock controller drivers
  arm64: dts: meson-axg: add clock DT info for Meson AXG SoC

 arch/arm64/Kconfig.platforms               |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi |  15 +
 drivers/clk/meson/Kconfig                  |   8 +
 drivers/clk/meson/Makefile                 |   1 +
 drivers/clk/meson/axg.c                    | 948 +++++++++++++++++++++++++++++
 drivers/clk/meson/axg.h                    | 126 ++++
 include/dt-bindings/clock/axg-clkc.h       |  72 +++
 7 files changed, 1171 insertions(+)
 create mode 100644 drivers/clk/meson/axg.c
 create mode 100644 drivers/clk/meson/axg.h
 create mode 100644 include/dt-bindings/clock/axg-clkc.h

-- 
2.15.0
