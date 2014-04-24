From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 24 Apr 2014 21:04:07 +0200
Subject: [PATCHv2 0/5] Berlin: add clock support
Message-ID: <1398366252-19582-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the clocks having their own register set. Other
clocks are available but they are sharing a common register in addition of their
own registers. They will be supported in a following series.

Also, I realized that when moving the pll nodes out of the clocks container,
they didn't get reorder.

Changes in v2:
 - reworked berlin_clk_recalc_rate() as suggested by Sebastian
 - some dts tweaks, as suggested by Antoine

Alexandre Belloni (5):
  clk: berlin: add support for clocks
  clk: berlin: add berlin clocks DT bindings documentation
  ARM: berlin/dt: add sdio clocks to BG2
  ARM: berlin/dt: add sdio clocks to BG2CD
  ARM: berlin/dt: add sdio clocks to BG2Q

 .../devicetree/bindings/clock/berlin-clock.txt     |   9 +-
 arch/arm/boot/dts/berlin2.dtsi                     |  42 ++++---
 arch/arm/boot/dts/berlin2cd.dtsi                   |  42 ++++---
 arch/arm/boot/dts/berlin2q.dtsi                    |  28 +++--
 drivers/clk/berlin/Makefile                        |   2 +-
 drivers/clk/berlin/clk.c                           | 134 +++++++++++++++++++++
 6 files changed, 220 insertions(+), 37 deletions(-)
 create mode 100644 drivers/clk/berlin/clk.c

-- 
1.9.1
