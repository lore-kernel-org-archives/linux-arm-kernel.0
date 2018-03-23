From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 23 Mar 2018 22:38:09 +0800
Subject: [PATCH v2 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
Message-ID: <20180323143816.200573-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This patch try to add AO clock and Reset driver for Amlogic's
Meson-AXG SoC.

 patch 1: it's a generic independent fix for the previous clock driver
 patch 2: factor the common code into a dedicated files
 patch 3-5: add the driver for AXG SoC
 patch 6-7: add the DTS part

changes since v1 at [0]: 
 - rebase to clk-meson's branch 'next/drivers' [1]
 - fix license, update to BSD-3-Clause
 - drop un-used include header file
 - 
                                                                                                                                            
[0] https://lkml.kernel.org/r/<20180209070026.193879-1-yixun.lan@amlogic.com>


Qiufang Dai (2):
  clk: meson-axg: Add AO Clock and Reset controller driver
  arm64: dts: meson-axg: add AO clock driver DT info

Yixun Lan (5):
  clk: meson: drop meson_aoclk_gate_regmap_ops
  clk: meson: aoclk: refactor common code into dedicated file
  dt-bindings: clock: axg-aoclkc: New binding for Meson-AXG SoC
  dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
  ARM64: dts: meson-axg: add an 32K alt aoclk

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  19 +++
 drivers/clk/meson/Makefile                         |   4 +-
 drivers/clk/meson/axg-aoclk.c                      | 162 +++++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h                      |  31 ++++
 drivers/clk/meson/gxbb-aoclk.c                     |  81 ++++-------
 drivers/clk/meson/gxbb-aoclk.h                     |   9 +-
 drivers/clk/meson/meson-aoclk.c                    |  76 ++++++++++
 drivers/clk/meson/meson-aoclk.h                    |  30 ++++
 include/dt-bindings/clock/axg-aoclkc.h             |  26 ++++
 include/dt-bindings/reset/axg-aoclkc.h             |  20 +++
 11 files changed, 399 insertions(+), 60 deletions(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h
 create mode 100644 drivers/clk/meson/meson-aoclk.c
 create mode 100644 drivers/clk/meson/meson-aoclk.h
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

-- 
2.15.1
