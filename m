From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 15 Sep 2014 18:12:43 +0200
Subject: [GIT PULL] at91: drivers for 3.18 #2 (bis)
In-Reply-To: <1409934969-11584-1-git-send-email-nicolas.ferre@atmel.com>
References: <1409934969-11584-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1410797563-13378-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

I re-send this pull-request with the work done by Maxime to take Arnd's
comments into annount: removal of the early_platform devices, and by keeping
the old mechanism with a function exported by the PIT timer and called by the
board files.

Here is the old message that I sent you: just as a reference.
"
This pull-request is focused on the work that Maxime did for migrating our
timer (PIT) to the clocksource sub-system. A big cleanup happened which allows
us to be even closer to the point when we have only the bare minimum in our
formerly crowded mach-at91 directory.
"

This pull-request goes on top of what is already in your at91/drivers branch.

Thanks, best regards,

The following changes since commit 405a72c5e78b5c560c8b2711d4000fa5eb063e1b:

  power: reset: at91-poweroff: fix wakeup status register index (2014-09-01 18:40:44 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-drivers2

for you to fetch changes up to b052ff30cd450c91a32e8e928979bca021462996:

  ARM: at91: PIT: Move the driver to drivers/clocksource (2014-09-15 17:55:48 +0200)

----------------------------------------------------------------
Second drivers series for AT91/3.18:
- move of the PIT (basic timer) from mach-at91 to its proper location:
  drivers/clocksource
- big cleanup of this driver along the way

----------------------------------------------------------------
Maxime Ripard (14):
      ARM: at91: PIT: Follow the general coding rules
      ARM: at91: generic.h: Add include safe guards
      ARM: at91: PIT: Use DIV_ROUND_CLOSEST to compute the cycles
      ARM: at91: PIT: Use of_have_populated_dt instead of CONFIG_OF
      ARM: at91: PIT: Rework probe functions
      ARM: at91: dt: Remove init_time definitions
      ARM: at91: PIT: Use consistent exit path in probe
      ARM: at91: PIT: Use pr_fmt
      ARM: at91: PIT: use request_irq instead of setup_irq
      ARM: at91: PIT: (Almost) remove the global variables
      ARM: at91: soc: Add init_time callback
      ARM: at91: Convert the boards to the init_time callback
      ARM: at91: Give the PIT irq as an argument of at91sam926x_pit_init
      ARM: at91: PIT: Move the driver to drivers/clocksource

 arch/arm/mach-at91/Kconfig              |   5 -
 arch/arm/mach-at91/Makefile             |   1 -
 arch/arm/mach-at91/at91sam9260.c        |   6 +
 arch/arm/mach-at91/at91sam9261.c        |   6 +
 arch/arm/mach-at91/at91sam9263.c        |   6 +
 arch/arm/mach-at91/at91sam926x_time.c   | 294 -------------------------------
 arch/arm/mach-at91/at91sam9g45.c        |   6 +
 arch/arm/mach-at91/at91sam9rl.c         |   6 +
 arch/arm/mach-at91/board-afeb-9260v1.c  |   2 +-
 arch/arm/mach-at91/board-cam60.c        |   2 +-
 arch/arm/mach-at91/board-cpu9krea.c     |   2 +-
 arch/arm/mach-at91/board-dt-sam9.c      |  10 --
 arch/arm/mach-at91/board-dt-sama5.c     |   9 -
 arch/arm/mach-at91/board-flexibity.c    |   2 +-
 arch/arm/mach-at91/board-foxg20.c       |   2 +-
 arch/arm/mach-at91/board-gsia18s.c      |   2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c |   2 +-
 arch/arm/mach-at91/board-sam9-l9260.c   |   2 +-
 arch/arm/mach-at91/board-sam9260ek.c    |   2 +-
 arch/arm/mach-at91/board-sam9261ek.c    |   4 +-
 arch/arm/mach-at91/board-sam9263ek.c    |   2 +-
 arch/arm/mach-at91/board-sam9g20ek.c    |   4 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c |   2 +-
 arch/arm/mach-at91/board-sam9rlek.c     |   2 +-
 arch/arm/mach-at91/board-snapper9260.c  |   2 +-
 arch/arm/mach-at91/board-stamp9g20.c    |   4 +-
 arch/arm/mach-at91/generic.h            |   8 +-
 arch/arm/mach-at91/setup.c              |   5 +
 arch/arm/mach-at91/soc.h                |   1 +
 drivers/clocksource/Kconfig             |   4 +
 drivers/clocksource/Makefile            |   1 +
 drivers/clocksource/timer-atmel-pit.c   | 296 ++++++++++++++++++++++++++++++++
 32 files changed, 363 insertions(+), 339 deletions(-)
 delete mode 100644 arch/arm/mach-at91/at91sam926x_time.c
 create mode 100644 drivers/clocksource/timer-atmel-pit.c

-- 
Nicolas Ferre
