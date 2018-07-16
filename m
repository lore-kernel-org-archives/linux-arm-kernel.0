From: jian.hu@amlogic.com (Jian Hu)
Date: Mon, 16 Jul 2018 16:11:45 +0800
Subject: [RESEND PATCH v2 0/2] clk: meson-g12a: Add EE clock controller driver
Message-ID: <1531728707-192230-1-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Clock driver for the Everything-Else part of
the Amlogic Meson-G12A SoC.

Changes since v1 at[1]
-fix typo of 'Everything'.
-change the word ?AmLogic? to 'Amlogic'
-squash patch 1 and 2.
-delete usless message of "Trying obsolete regs".
-delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
-rebase on top of the "next/drivers" branch, and add g12a clock patch.
-add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
 g12a_sd_emmc_c_clk0_sel.

I have forgetten adding the PATCH version tag, so resend it 

[1]https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu at amlogic.com

Jian Hu (2):
  dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
  clk: meson-g12a: Add EE Clock controller driver

 .../bindings/clock/amlogic,gxbb-clkc.txt           |   1 +
 drivers/clk/meson/Kconfig                          |  10 +
 drivers/clk/meson/Makefile                         |   1 +
 drivers/clk/meson/g12a.c                           | 994 +++++++++++++++++++++
 drivers/clk/meson/g12a.h                           | 122 +++
 include/dt-bindings/clock/g12a-clkc.h              |  92 ++
 6 files changed, 1220 insertions(+)
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

-- 
1.9.1
