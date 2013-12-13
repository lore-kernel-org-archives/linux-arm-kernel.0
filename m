From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Dec 2013 23:16:51 +0100
Subject: [GIT PULL] get rid of <mach/timex.h>
Message-ID: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh

for you to fetch changes up to c24eb46490c8232c08c82cd591ba332284d257b2:

  ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too (2013-12-07 23:31:28 +0100)

I'd like to get these changes into 3.14-rc1, so it would be great if you
could take it into armsoc for some exposure into next.

The kbuild test robot is happy with these changes, and I did several
build tests, too, so I don't expect any breakage.

Merging this series will result in a few merge conflicts. I pushed a
branch dropmachtimexh-merged into my repository where you can see how I
resolved them merging in current next/master into my tag.

----------------------------------------------------------------
This cleanup series gets rid of <mach/timex.h> for platforms not using
ARCH_MULTIPLATFORM. (For multi-platform code it's already unused since
387798b (ARM: initial multiplatform support).)

To make this work some code out of arch/arm needed to be adapted. Apart from two
changes in drivers/rtc I got the relevant maintainer Acks. For the rtc changes
I didn't get any feedback by Alexandro Zummo since I posted the first change 5
weeks ago despite pinging it several times. The current state seems to be that
Andrew Morton takes odd fixes, but I couldn't get him to give an Ack either.
(One of the two patches is in his queue, but I expect him to drop that as soon
as the patch makes it in via another path. Didn't get any feedback here, too.)

----------------------------------------------------------------
Linus Walleij (1):
      ARM/serial: at91: switch atmel serial to use gpiolib

Uwe Kleine-K?nig (11):
      rtc: at91sam9: include <mach/hardware.h> explicitly
      rtc: pxa: drop unused #define TIMER_FREQ
      clocksource: sirf/marco+prima2: drop usage of CLOCK_TICK_RATE
      ARM: sa1100: stop using mach/timex.h
      ARM: netx: stop using mach/timex.h
      ARM: mmp: stop using mach/timex.h
      ARM: ep93xx: stop using mach/timex.h
      ARM: at91: don't use <mach/timex.h>
      input: ixp4xx-beeper: don't use symbols from <mach/timex.h>
      ARM: ixp4xx: stop using <mach/timex.h>
      ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too

 .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
 arch/arm/include/asm/timex.h                       |  6 ---
 arch/arm/mach-at91/at91rm9200.c                    |  1 +
 arch/arm/mach-at91/at91rm9200_devices.c            | 11 ++++-
 arch/arm/mach-at91/at91rm9200_time.c               |  1 +
 arch/arm/mach-at91/at91sam9260.c                   |  1 +
 arch/arm/mach-at91/at91sam9260_devices.c           |  8 ++++
 arch/arm/mach-at91/at91sam9261.c                   |  1 +
 arch/arm/mach-at91/at91sam9261_devices.c           |  5 +++
 arch/arm/mach-at91/at91sam9263.c                   |  1 +
 arch/arm/mach-at91/at91sam9263_devices.c           |  5 +++
 arch/arm/mach-at91/at91sam926x_time.c              |  1 +
 arch/arm/mach-at91/at91sam9g45.c                   |  1 +
 arch/arm/mach-at91/at91sam9g45_devices.c           |  6 +++
 arch/arm/mach-at91/at91sam9rl.c                    |  1 +
 arch/arm/mach-at91/at91sam9rl_devices.c            |  6 +++
 arch/arm/mach-at91/at91x40.c                       |  2 +-
 arch/arm/mach-at91/at91x40_time.c                  |  1 +
 arch/arm/mach-at91/board-gsia18s.c                 |  1 +
 arch/arm/mach-at91/board-pcontrol-g20.c            |  1 +
 arch/arm/mach-at91/board-stamp9g20.c               |  1 +
 arch/arm/mach-at91/include/mach/at91x40.h          |  2 +
 arch/arm/mach-at91/include/mach/timex.h            | 37 ----------------
 arch/arm/mach-at91/pm.c                            |  1 +
 arch/arm/mach-clps711x/include/mach/timex.h        |  2 -
 arch/arm/mach-davinci/include/mach/timex.h         | 22 ----------
 arch/arm/mach-dove/include/mach/timex.h            |  9 ----
 arch/arm/mach-ebsa110/include/mach/timex.h         | 19 ---------
 arch/arm/mach-ep93xx/core.c                        |  2 +-
 arch/arm/mach-ep93xx/include/mach/timex.h          |  5 ---
 arch/arm/mach-exynos/include/mach/timex.h          | 29 -------------
 arch/arm/mach-footbridge/include/mach/timex.h      | 18 --------
 arch/arm/mach-gemini/include/mach/timex.h          | 13 ------
 arch/arm/mach-integrator/include/mach/timex.h      | 26 ------------
 arch/arm/mach-iop13xx/include/mach/timex.h         |  1 -
 arch/arm/mach-iop32x/include/mach/timex.h          |  6 ---
 arch/arm/mach-iop33x/include/mach/timex.h          |  6 ---
 arch/arm/mach-ixp4xx/common.c                      |  3 +-
 arch/arm/mach-ixp4xx/include/mach/timex.h          | 16 -------
 arch/arm/mach-kirkwood/include/mach/timex.h        | 10 -----
 arch/arm/mach-ks8695/include/mach/timex.h          | 21 ----------
 arch/arm/mach-lpc32xx/include/mach/timex.h         | 28 -------------
 arch/arm/mach-mmp/include/mach/timex.h             | 13 ------
 arch/arm/mach-mmp/time.c                           | 12 ++++--
 arch/arm/mach-msm/include/mach/timex.h             | 21 ----------
 arch/arm/mach-mv78xx0/include/mach/timex.h         |  9 ----
 arch/arm/mach-netx/include/mach/timex.h            | 20 ---------
 arch/arm/mach-netx/time.c                          |  6 ++-
 arch/arm/mach-omap1/include/mach/timex.h           |  5 ---
 arch/arm/mach-omap2/include/mach/timex.h           |  5 ---
 arch/arm/mach-orion5x/include/mach/timex.h         | 11 -----
 arch/arm/mach-pxa/include/mach/timex.h             | 34 ---------------
 arch/arm/mach-realview/include/mach/timex.h        | 23 ----------
 arch/arm/mach-rpc/include/mach/timex.h             | 17 --------
 arch/arm/mach-s3c24xx/include/mach/timex.h         | 24 -----------
 arch/arm/mach-s3c64xx/include/mach/timex.h         | 24 -----------
 arch/arm/mach-s5p64x0/include/mach/timex.h         | 27 ------------
 arch/arm/mach-s5pc100/include/mach/timex.h         | 24 -----------
 arch/arm/mach-s5pv210/include/mach/timex.h         | 29 -------------
 arch/arm/mach-sa1100/include/mach/timex.h          | 12 ------
 arch/arm/mach-sa1100/time.c                        |  4 +-
 arch/arm/mach-shmobile/include/mach/timex.h        |  6 ---
 arch/arm/mach-spear/include/mach/timex.h           | 19 ---------
 arch/arm/mach-versatile/include/mach/timex.h       | 23 ----------
 arch/arm/mach-w90x900/include/mach/timex.h         | 25 -----------
 arch/arm/plat-omap/include/plat/timex.h            | 33 ---------------
 drivers/clocksource/timer-marco.c                  | 13 +++---
 drivers/clocksource/timer-prima2.c                 | 16 ++++---
 drivers/input/misc/ixp4xx-beeper.c                 |  2 +-
 drivers/rtc/rtc-at91sam9.c                         |  2 +-
 drivers/rtc/rtc-pxa.c                              |  1 -
 drivers/tty/serial/atmel_serial.c                  | 49 ++++++++++++++--------
 include/linux/platform_data/atmel.h                |  1 +
 73 files changed, 128 insertions(+), 722 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/timex.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/timex.h
 delete mode 100644 arch/arm/mach-dove/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/timex.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/timex.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/timex.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/timex.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/timex.h
 delete mode 100644 arch/arm/mach-msm/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/timex.h
 delete mode 100644 arch/arm/mach-netx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/timex.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/timex.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/timex.h
 delete mode 100644 arch/arm/mach-realview/include/mach/timex.h
 delete mode 100644 arch/arm/mach-rpc/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/timex.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/timex.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear/include/mach/timex.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/timex.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/timex.h
 delete mode 100644 arch/arm/plat-omap/include/plat/timex.h
