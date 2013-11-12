From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 12 Nov 2013 22:41:02 +0100
Subject: [PATCH 0/4] Getting rid of mach/timex.h usages below arch/arm
Message-ID: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch series fixes all users of CLOCK_TICK_RATE to not use the the
symbol provided by mach/timex.h. Together with a few patches I already
sent out earlier [1] all users are fixed which should allow us to drop
including mach/timex.h from asm/timex.h and remove all mach/timex.h
files.

Best regards
Uwe

[1] 
	ARM: u300: fix timekeeping when periodic mode is used
	rtc: pxa: drop usage of CLOCK_TICK_RATE
	clocksource: sirf/marco+prima2: drop usage of CLOCK_TICK_RATE
	watchdog: sirf: don't depend on dummy value of CLOCK_TICK_RATE

Uwe Kleine-K?nig (4):
  ARM: sa1100: stop using mach/timex.h
  ARM: netx: stop using mach/timex.h
  ARM: mmp: stop using mach/timex.h
  ARM: ep93xx: stop using mach/timex.h

 arch/arm/mach-ep93xx/core.c |  3 ++-
 arch/arm/mach-mmp/time.c    | 12 +++++++++---
 arch/arm/mach-netx/time.c   |  6 ++++--
 arch/arm/mach-sa1100/time.c |  4 +++-
 4 files changed, 18 insertions(+), 7 deletions(-)

-- 
1.8.4.2
