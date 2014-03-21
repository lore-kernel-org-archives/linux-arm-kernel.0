From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Mar 2014 12:43:35 +0100
Subject: [PATCH 0/5] berlin: initial support for the clocks
Message-ID: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the berlin PLLs. This allows to remove the bogus
fixed clocks that are used in the SoCs dts includes.

For now, I have left out the AVPLL to ease reviewing.

This is tested on a BG2Q DMP.

Alexandre Belloni (5):
  clk: berlin: add support for berlin plls
  clk: berlin: add berlin clocks DT bindings documentation
  ARM: berlin/dt: add cpupll and syspll support to BG2Q
  ARM: berlin/dt: add cpupll and syspll support to BG2CD
  ARM: berlin/dt: add cpupll and syspll support to BG2

 .../devicetree/bindings/clock/berlin-clock.txt     |  29 ++++++
 arch/arm/boot/dts/berlin2.dtsi                     |  56 ++++++++----
 arch/arm/boot/dts/berlin2cd.dtsi                   |  56 ++++++++----
 arch/arm/boot/dts/berlin2q.dtsi                    |  20 ++++-
 drivers/clk/Makefile                               |   1 +
 drivers/clk/berlin/Makefile                        |   1 +
 drivers/clk/berlin/clk.h                           |  35 ++++++++
 drivers/clk/berlin/pll-berlin2.c                   |  41 +++++++++
 drivers/clk/berlin/pll-berlin2q.c                  |  41 +++++++++
 drivers/clk/berlin/pll.c                           | 100 +++++++++++++++++++++
 10 files changed, 344 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/berlin-clock.txt
 create mode 100644 drivers/clk/berlin/Makefile
 create mode 100644 drivers/clk/berlin/clk.h
 create mode 100644 drivers/clk/berlin/pll-berlin2.c
 create mode 100644 drivers/clk/berlin/pll-berlin2q.c
 create mode 100644 drivers/clk/berlin/pll.c

-- 
1.8.3.2
