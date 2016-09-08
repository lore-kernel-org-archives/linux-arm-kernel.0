From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  8 Sep 2016 13:57:18 +0200
Subject: [PATCH 0/5] AT91: sckc improvements
Message-ID: <20160908115723.11878-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set improves the slow clock controller driver.

The first patch simply moves some code around to avoid having extern
functions declared.

The second patch adds support for the SCKC found on sama5d4 and later.
It is notably missing the OSC32EN bit.
The third and fourth patches make use of this new driver (DT ABI is not
broken \o/)

Finally, there is an optimization. Trying to find wether the slow
oscillator is already stable to avoid waiting 1.2s twice in the boot
process.


Alexandre Belloni (5):
  clk: at91: move slow clock controller clocks to sckc.c
  clk: at91: Add sama5d4 sckc support
  ARM: dts: at91: sama5d4: use proper sckc compatible
  ARM: dts: at91: sama5d2: use correct sckc compatible
  clk: at91: sckc: optimize boot time

 .../devicetree/bindings/clock/at91-clock.txt       |   3 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  26 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  27 +-
 drivers/clk/at91/clk-slow.c                        | 353 ----------------
 drivers/clk/at91/sckc.c                            | 447 ++++++++++++++++++++-
 drivers/clk/at91/sckc.h                            |  22 -
 6 files changed, 456 insertions(+), 422 deletions(-)
 delete mode 100644 drivers/clk/at91/sckc.h

-- 
2.9.3
