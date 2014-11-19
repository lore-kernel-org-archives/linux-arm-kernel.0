From: carlo@caione.org (Carlo Caione)
Date: Wed, 19 Nov 2014 11:32:19 +0100
Subject: [PATCH 0/4] ARM: meson: add clock/reset controller
Message-ID: <1416393143-20434-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces preliminary support for the clock/reset controller
found on Amlogic MesonX SoCs and enables it for the Meson6.

The reset controller is in charge of shutting off the clock to disable modules
and submodules within the chip. Unfortunately the documentation we have does
not explicit which clock is gated but only which peripheral is reset so the
clocks introduced are not gated but the peripherals are reset using the
reset controller.

DTS patches will follow.

Carlo Caione (4):
  ARM: meson: add basic infrastructure for clocks
  ARM: meson: add reset controller
  ARM: meson: enable reset controller in kconfig
  ARM: meson: add documentation for reset/clock controller

 .../bindings/clock/amlogic,meson6-clkc.txt         |  45 ++++
 arch/arm/mach-meson/Kconfig                        |   2 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/meson/Makefile                         |   8 +
 drivers/clk/meson/clk-pll.c                        | 298 +++++++++++++++++++++
 drivers/clk/meson/clkc.c                           | 151 +++++++++++
 drivers/clk/meson/clkc.h                           | 174 ++++++++++++
 drivers/clk/meson/meson6-clkc.c                    | 178 ++++++++++++
 drivers/clk/meson/rstc.c                           | 152 +++++++++++
 include/dt-bindings/clock/meson6-clkc.h            |  18 ++
 10 files changed, 1027 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson6-clkc.txt
 create mode 100644 drivers/clk/meson/Makefile
 create mode 100644 drivers/clk/meson/clk-pll.c
 create mode 100644 drivers/clk/meson/clkc.c
 create mode 100644 drivers/clk/meson/clkc.h
 create mode 100644 drivers/clk/meson/meson6-clkc.c
 create mode 100644 drivers/clk/meson/rstc.c
 create mode 100644 include/dt-bindings/clock/meson6-clkc.h

-- 
1.9.1
