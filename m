From: carlo@caione.org (Carlo Caione)
Date: Sat, 16 May 2015 12:48:50 +0200
Subject: [PATCH v2 0/3] clk: meson: Add clock controller
Message-ID: <1431773333-23567-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patchset introduces preliminary support for the clock controller
found on Amlogic MesonX SoCs and enables it for the Meson8b.

DTS patches with support for Meson8b SoCs will follow.

Changelog:

v1->v2:
   * fix double CLK_IGNORE_UNUSED in clk-pll.c
   * fix comment in meson8b-clkc.h

Carlo Caione (3):
  clk: meson: Add support for Meson clock controller
  clk: meson: Document bindings for Meson8b clock controller
  clk: meson8b: Add support for Meson8b clocks

 .../bindings/clock/amlogic,meson8b-clkc.txt        |  40 +++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/meson/Makefile                         |   6 +
 drivers/clk/meson/clk-cpu.c                        | 291 +++++++++++++++++++++
 drivers/clk/meson/clk-pll.c                        | 231 ++++++++++++++++
 drivers/clk/meson/clkc.c                           | 234 +++++++++++++++++
 drivers/clk/meson/clkc.h                           | 187 +++++++++++++
 drivers/clk/meson/meson8b-clkc.c                   | 182 +++++++++++++
 include/dt-bindings/clock/meson8b-clkc.h           |  20 ++
 9 files changed, 1192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
 create mode 100644 drivers/clk/meson/Makefile
 create mode 100644 drivers/clk/meson/clk-cpu.c
 create mode 100644 drivers/clk/meson/clk-pll.c
 create mode 100644 drivers/clk/meson/clkc.c
 create mode 100644 drivers/clk/meson/clkc.h
 create mode 100644 drivers/clk/meson/meson8b-clkc.c
 create mode 100644 include/dt-bindings/clock/meson8b-clkc.h

-- 
1.9.1
