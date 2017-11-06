From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 6 Nov 2017 15:31:34 +0800
Subject: [PATCH 0/2] add clk controller driver for Meson-AXG SoC
Message-ID: <20171106073134.13830-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch 1: add driver for the clk controller which found in Meson AXG

  Note, we deliberately create a seperate source file for the Meson AXG
series, instead of sharing code with previous GXBB/GXL - the file axg.c
It would help us maintaining the code more easily.

patch 2: describe the DT info for Meson AXG

Qiufang Dai (2):
  clk: meson-axg: add clock controller drivers
  arm64: dts: meson-axg: add clock DT info for Meson AXG SoC

 arch/arm64/Kconfig.platforms               |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi |  16 +
 drivers/clk/meson/Kconfig                  |   8 +
 drivers/clk/meson/Makefile                 |   1 +
 drivers/clk/meson/axg.c                    | 948 +++++++++++++++++++++++++++++
 drivers/clk/meson/axg.h                    | 127 ++++
 include/dt-bindings/clock/axg-clkc.h       |  72 +++
 7 files changed, 1173 insertions(+)
 create mode 100644 drivers/clk/meson/axg.c
 create mode 100644 drivers/clk/meson/axg.h
 create mode 100644 include/dt-bindings/clock/axg-clkc.h

-- 
2.14.1
