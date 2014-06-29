From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 29 Jun 2014 20:32:20 +0200
Subject: [PATCH 0/4] Migrate PXA27x platforms to clock framework
Message-ID: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the RFC posted in [1] didn't meet an unrivaled success for
review, I'm posting this serie for PXA27x transition to clock
framework.

This transition is needed :
 - to enable device-tree drivers port, as clocks are needed almost
   everywhere
 - to enable the long term multi-platform kernel to support PXA

As I had said before, this serie aims at :
 - keeping legacy platforms working (ie. without device-tree)
 - enable PXA27x to work with a device-tree kernel, and hence
   open the way to drivers conversion
 - be robust enough to support pxa25x and pxa3xx later inclusion
   with almost no change to clk-pxa-dt.c.

As this serie is holding the rest of the device-tree drivers
port, I'd like it to be reviewed, even it's an old unsexy
platform.

Cheers.

--
Robert

[1]: http://www.spinics.net/lists/arm-kernel/msg337521.html

Robert Jarzmik (4):
  clk: add pxa27x clock drivers
  dts: add devicetree bindings for pxa27x clocks
  arm: pxa: Transition pxa27x to clk framework
  clk: dts: document pxa27x clock binding

 .../devicetree/bindings/clock/pxa-clock.txt        |  32 ++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/pxa27x.dtsi                      | 134 ++++++++-
 arch/arm/mach-pxa/Makefile                         |   8 +-
 arch/arm/mach-pxa/pxa27x.c                         | 190 +-----------
 drivers/clk/Makefile                               |   1 +
 drivers/clk/pxa/Makefile                           |   4 +
 drivers/clk/pxa/clk-pxa-dt.c                       |  76 +++++
 drivers/clk/pxa/clk-pxa27x.c                       | 324 +++++++++++++++++++++
 drivers/clk/pxa/clk-pxa2xx.c                       |  74 +++++
 drivers/clk/pxa/clk-pxa2xx.h                       |  47 +++
 include/dt-bindings/clock/pxa2xx-clock.h           |  45 +++
 12 files changed, 757 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/pxa-clock.txt
 create mode 100644 drivers/clk/pxa/Makefile
 create mode 100644 drivers/clk/pxa/clk-pxa-dt.c
 create mode 100644 drivers/clk/pxa/clk-pxa27x.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.h
 create mode 100644 include/dt-bindings/clock/pxa2xx-clock.h

-- 
2.0.0.rc2
