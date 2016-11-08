From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 08 Nov 2016 23:19:22 +0100
Subject: [GIT PULL] pxa for v4.10
Message-ID: <87a8d9wr6d.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa 4.10 cycle. This pull request strides
off from my usual ones as its spans more than just mach-pxa.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.10

for you to fetch changes up to e413bd33ac44b6d0bebc0ef2ac19cbe7558a7303:

  ARM: pxa: fix pxa25x interrupt init (2016-11-05 21:48:18 +0100)

----------------------------------------------------------------
This is the pxa changes for v4.10 cycle.

This cycle is covering :
 - some clock fixes common with sa1100 architecture
 - the consequence of the pxa_camera conversion to v4l2
 - a small irq related fix for pxa25x device-tree only

----------------------------------------------------------------
Robert Jarzmik (8):
      ARM: sa11x0/pxa: acquire timer rate from the clock rate
      watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
      ARM: sa11x0/pxa: get rid of get_clock_tick_rate
      ARM: pxa: pxa_cplds: honor probe deferral
      ARM: pxa: mioa701: use the new pxa_camera platform_data
      ARM: pxa: ezx: use the new pxa_camera platform_data
      ARM: pxa: em-x270: use the new pxa_camera platform_data
      ARM: pxa: fix pxa25x interrupt init

Russell King - ARM Linux (1):
      clk: pxa25x: OSTIMER0 clocks from the main oscillator

Wei Yongjun (1):
      ARM: pxa: remove duplicated include from spitz.c

 arch/arm/mach-pxa/corgi.c                    |   1 -
 arch/arm/mach-pxa/em-x270.c                  |  89 +++++---------
 arch/arm/mach-pxa/ezx.c                      | 176 +++++++++++----------------
 arch/arm/mach-pxa/generic.c                  |  18 +--
 arch/arm/mach-pxa/include/mach/hardware.h    |   2 -
 arch/arm/mach-pxa/mioa701.c                  |  13 +-
 arch/arm/mach-pxa/pxa25x.c                   |   2 +-
 arch/arm/mach-pxa/pxa_cplds_irqs.c           |  11 +-
 arch/arm/mach-pxa/spitz.c                    |   1 -
 arch/arm/mach-sa1100/generic.c               |   2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h |   4 -
 drivers/clk/pxa/clk-pxa25x.c                 |   2 +-
 drivers/clocksource/pxa_timer.c              |  11 +-
 drivers/watchdog/sa1100_wdt.c                |  24 +++-
 include/clocksource/pxa.h                    |   3 +-
 15 files changed, 142 insertions(+), 217 deletions(-)


-- 
Robert
