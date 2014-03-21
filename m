From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Mar 2014 21:08:36 +0100
Subject: [PATCH v2 0/5] berlin: initial support for the clocks
Message-ID: <1395432521-11055-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the berlin PLLs. This allows to remove the bogus
fixed clocks that are used in the SoCs dts includes.

For now, I have left out the AVPLL to ease reviewing.

This is tested on a BG2Q DMP.

Changes in v2:
 - reworked the DT bindings documentation
 - removed the cpuclk node
 - moved the pll node in the soc node and ordered them by address.
 - renamed clk.h => common.h and removed the stray #include
 - reordered the includes in pll-*.c
 - extended the vcodiv tables so that we can't overflow it
 - reordered the struct berlin_pllmap members assignements
 - replaced the void *data member of the struct berlin_pll by a
   struct berlin_pllmap *map

Alexandre Belloni (5):
  clk: berlin: add support for berlin plls
  clk: berlin: add berlin clocks DT bindings documentation
  ARM: berlin/dt: add cpupll and syspll support to BG2Q
  ARM: berlin/dt: add cpupll and syspll support to BG2CD
  ARM: berlin/dt: add cpupll and syspll support to BG2

 .../devicetree/bindings/clock/berlin-clock.txt     |  29 ++++++
 arch/arm/boot/dts/berlin2.dtsi                     |  48 +++++----
 arch/arm/boot/dts/berlin2cd.dtsi                   |  48 +++++----
 arch/arm/boot/dts/berlin2q.dtsi                    |  22 +++--
 drivers/clk/Makefile                               |   1 +
 drivers/clk/berlin/Makefile                        |   4 +
 drivers/clk/berlin/common.h                        |  35 +++++++
 drivers/clk/berlin/pll-berlin2.c                   |  42 ++++++++
 drivers/clk/berlin/pll-berlin2q.c                  |  42 ++++++++
 drivers/clk/berlin/pll.c                           | 107 +++++++++++++++++++++
 10 files changed, 337 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/berlin-clock.txt
 create mode 100644 drivers/clk/berlin/Makefile
 create mode 100644 drivers/clk/berlin/common.h
 create mode 100644 drivers/clk/berlin/pll-berlin2.c
 create mode 100644 drivers/clk/berlin/pll-berlin2q.c
 create mode 100644 drivers/clk/berlin/pll.c

-- 
1.8.3.2
