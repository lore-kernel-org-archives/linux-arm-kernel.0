From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 14 Jul 2014 17:54:17 +0200
Subject: [PATCH v2 0/6] Migrate PXA27x platforms to clock framework
Message-ID: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second opus of this serie.
>From the previous one, the approach was changed as Mike and Haojian asked :
 - the device-tree description shrunk to almost nothing
 - the device-tree driver is common amongst all PXA variants
 - a common clk-pxa.c is (will be) used amongst all PXA variants

As before, the goal remains the same :
 - keeping legacy platforms working (ie. without device-tree)
 - enable PXA27x to work with a device-tree kernel, and hence
   open the way to drivers conversion
 - be robust enough to support pxa25x and pxa3xx later inclusion
   with almost no change to clk-pxa-dt.c.

Robert Jarzmik (6):
  clk: add pxa clocks infrastructure
  clk: dts: document pxa clock binding
  arm: pxa: add clock pll selection bits
  clk: add pxa27x clock drivers
  dts: add devicetree bindings for pxa27x clocks
  arm: pxa: Transition pxa27x to clk framework

 .../devicetree/bindings/clock/pxa-clock.txt        |  16 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/pxa27x.dtsi                      |  20 +-
 arch/arm/mach-pxa/Makefile                         |   8 +-
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h       |  10 +
 arch/arm/mach-pxa/pxa27x.c                         | 186 +----------
 drivers/clk/Makefile                               |   1 +
 drivers/clk/pxa/Makefile                           |   2 +
 drivers/clk/pxa/clk-pxa.c                          |  97 ++++++
 drivers/clk/pxa/clk-pxa.h                          | 107 ++++++
 drivers/clk/pxa/clk-pxa27x.c                       | 370 +++++++++++++++++++++
 include/dt-bindings/clock/pxa-clock.h              |  77 +++++
 12 files changed, 716 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/pxa-clock.txt
 create mode 100644 drivers/clk/pxa/Makefile
 create mode 100644 drivers/clk/pxa/clk-pxa.c
 create mode 100644 drivers/clk/pxa/clk-pxa.h
 create mode 100644 drivers/clk/pxa/clk-pxa27x.c
 create mode 100644 include/dt-bindings/clock/pxa-clock.h

-- 
2.0.0.rc2
