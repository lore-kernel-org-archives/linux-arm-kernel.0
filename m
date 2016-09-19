From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 19 Sep 2016 21:12:11 +0200
Subject: [PATCH 0/4] kill get_clock_tick_rate()
Message-ID: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie aims at killing get_clock_tick_rate() from pxa and sa1100 and replace
it by clock API calls.

I'd like to have this reviewed and acked afterwards at least by :
 - Russell for the mach-sa1100 and sa1100_wdt.c
 - Stephen or Michael for the clk-pxa25x.c
 - Thomas or Daniel for the clocksource part
 - Wim for sa1100_wdt.c

If the review converges, I'd also like to take it through the pxa/for-next tree,
or alternatively Russell's tree if there is a dependency I'm not seeing, for
v4.10 cycle.

Cheers.

Robert Jarzmik (3):
  ARM: sa11x0/pxa: acquire timer rate from the clock rate
  watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
  ARM: sa11x0/pxa: get rid of get_clock_tick_rate

Russell King - ARM Linux (1):
  clk: pxa25x: OSTIMER0 clocks from the main oscillator

 arch/arm/mach-pxa/generic.c                  | 18 +-----------------
 arch/arm/mach-pxa/include/mach/hardware.h    |  2 --
 arch/arm/mach-sa1100/generic.c               |  2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h |  4 ----
 drivers/clk/pxa/clk-pxa25x.c                 |  2 +-
 drivers/clocksource/pxa_timer.c              | 11 +++++------
 drivers/watchdog/sa1100_wdt.c                | 24 +++++++++++++++++++++++-
 include/clocksource/pxa.h                    |  3 +--
 8 files changed, 32 insertions(+), 34 deletions(-)

-- 
2.1.4
