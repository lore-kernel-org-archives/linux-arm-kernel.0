From: jian.hu@amlogic.com (Jian Hu)
Date: Thu, 8 Nov 2018 21:15:09 +0800
Subject: [PATCH v4 0/2] clk: meson-g12a: Add EE clock controller driver
Message-ID: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3 at[4]
-add fixed clocks clk_regmap definition

Changes since v2 at[2]
-fix fixed clocks's descriptions
-fix aligment
-add enable bit for plls base on [3] patches
-add fixed clock gate bit

Changes since v1 at[1]
-fix typo of 'Everything'.
-change the word 'AmLogic' to 'Amlogic'
-squash patch 1 and 2.
-delete usless message of "Trying obsolete regs".
-delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
-rebase on top of the "next/drivers" branch, and add g12a clock patch.
-add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
 g12a_sd_emmc_c_clk0_sel.

[1]https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu at amlogic.com
[2]https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu at amlogic.com
[3]https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet at baylibre.com
[4]https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu at amlogic.com

Jian Hu (2):
  dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
  clk: meson-g12a: Add EE Clock controller driver

 .../bindings/clock/amlogic,gxbb-clkc.txt           |    1 +
 drivers/clk/meson/Kconfig                          |   10 +
 drivers/clk/meson/Makefile                         |    1 +
 drivers/clk/meson/g12a.c                           | 1134 ++++++++++++++++++++
 drivers/clk/meson/g12a.h                           |  128 +++
 include/dt-bindings/clock/g12a-clkc.h              |   93 ++
 6 files changed, 1367 insertions(+)
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

-- 
1.9.1
