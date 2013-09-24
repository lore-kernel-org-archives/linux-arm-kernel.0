From: john.stultz@linaro.org (John Stultz)
Date: Tue, 24 Sep 2013 16:58:42 -0700
Subject: [GIT PULL] drivers/clocksource: sched_clock_register() conversion
 for 3.13 (via tip/timers/core)
Message-ID: <52422732.5000501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Daniel,
    Here's the sched_clock_register conversion that Stephen did earlier
this summer, as part of extending the generic sched_clock code to
support 64bit counters. Unfortunately the prereqs for this series missed
getting into tip/timers/core for 3.12, so I never sent out this pull
request. But now that the prereqs are in tip/timers/core for 3.13, I've
merge it up and I wanted to go ahead and send this out.

Let me know if you have any issues or concerns.

thanks
-john



The following changes since commit 389e067032fbb96e439abafae848dd447e4cafb4:

  Merge branch 'fortglx/3.12/time' into fortglx/3.13/time (2013-09-16
18:54:07 -0700)

are available in the git repository at:


  git://git.linaro.org/people/jstultz/linux.git
fordlezcano/3.13/sched-clock64-conversion

for you to fetch changes up to 4d655d1ae17259b53e89e8dc477557e0f162a5e3:

  Merge remote-tracking branch 'tip/timers/core' into
fordlezcano/3.13/sched-clock64-conversion (2013-09-24 16:44:43 -0700)

----------------------------------------------------------------

John Stultz (1):
      Merge remote-tracking branch 'tip/timers/core' into
fordlezcano/3.13/sched-clock64-conversion

Stephen Boyd (11):
      clocksource: bcm2835: Switch to sched_clock_register()
      clocksource: dbx500-prcmu: Switch to sched_clock_register()
      clocksource: dw_apb_timer_of: Switch to sched_clock_register()
      clocksource: mxs_timer: Switch to sched_clock_register()
      clocksource: nomadik: Switch to sched_clock_register()
      clocksource: samsung_pwm_timer: Switch to sched_clock_register()
      clocksource: tegra: Switch to sched_clock_register()
      clocksource: time-armada-370-xp: Switch to sched_clock_register()
      clocksource: sirf: Switch to sched_clock_register() and use 64 bits
      clocksource: vf_pit_timer: Switch to sched_clock_register()
      sched_clock: Deprecate setup_sched_clock()

 drivers/clocksource/bcm2835_timer.c       | 4 ++--
 drivers/clocksource/clksrc-dbx500-prcmu.c | 5 ++---
 drivers/clocksource/dw_apb_timer_of.c     | 4 ++--
 drivers/clocksource/mxs_timer.c           | 4 ++--
 drivers/clocksource/nomadik-mtu.c         | 4 ++--
 drivers/clocksource/samsung_pwm_timer.c   | 4 ++--
 drivers/clocksource/tegra20_timer.c       | 4 ++--
 drivers/clocksource/time-armada-370-xp.c  | 4 ++--
 drivers/clocksource/timer-prima2.c        | 6 +++---
 drivers/clocksource/vf_pit_timer.c        | 4 ++--
 include/linux/sched_clock.h               | 3 ++-
 11 files changed, 23 insertions(+), 23 deletions(-)
