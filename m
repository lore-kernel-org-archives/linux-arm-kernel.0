From: carlo@caione.org (Carlo Caione)
Date: Mon,  1 Jun 2015 13:13:52 +0200
Subject: [PATCH v3 0/3] clk: meson: Add clock controller
Message-ID: <1433157235-17275-1-git-send-email-carlo@caione.org>
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

v2->v3:
  * fix includes
  * use divider_* functions for clk-cpu
  * fix memory leak in meson_clk_register_composite()
  * mask operations now use GENMASK
  * const-ify global configuration variables in meson8b-clkc.c
  * several more small fixes

Carlo Caione (3):
  clk: meson: Add support for Meson clock controller
  clk: meson: Document bindings for Meson8b clock controller
  clk: meson8b: Add support for Meson8b clocks

 .../bindings/clock/amlogic,meson8b-clkc.txt        |  40 ++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/meson/Makefile                         |   6 +
 drivers/clk/meson/clk-cpu.c                        | 234 +++++++++++++++++++
 drivers/clk/meson/clk-pll.c                        | 227 +++++++++++++++++++
 drivers/clk/meson/clkc.c                           | 247 +++++++++++++++++++++
 drivers/clk/meson/clkc.h                           | 187 ++++++++++++++++
 drivers/clk/meson/meson8b-clkc.c                   | 196 ++++++++++++++++
 include/dt-bindings/clock/meson8b-clkc.h           |  25 +++
 9 files changed, 1163 insertions(+)
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
