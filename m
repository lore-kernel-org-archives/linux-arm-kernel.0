From: john.stultz@linaro.org (John Stultz)
Date: Tue, 30 Jul 2013 11:50:49 -0700
Subject: [GIT PULL] 64bit friendly generic sched_clock() base for 3.12
Message-ID: <51F80B09.8060509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thomas, Olof,
     Here is the common base changes in Stephen's "64bit friendly 
generic sched_clock()" patch series. This common base will be needed so 
that following patch series can be merged via both the tip/timers/core 
and arm-soc trees independently.

Please let me know if you have any issues or objections with this set.

thanks
-john


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

   git://git.linaro.org/people/jstultz/linux.git 
fortglx/3.12/sched-clock64-base

for you to fetch changes up to e7e3ff1bfe9c42ee31172e9afdc0383a9e595e29:

   sched_clock: Add support for >32 bit sched_clock (2013-07-30 11:24:21 
-0700)

----------------------------------------------------------------
Stephen Boyd (4):
       clocksource: Extract max nsec calculation into separate function
       sched_clock: Use seqcount instead of rolling our own
       sched_clock: Use an hrtimer instead of timer
       sched_clock: Add support for >32 bit sched_clock

  include/linux/clocksource.h |   2 +
  include/linux/sched_clock.h |   2 +
  kernel/time/clocksource.c   |  45 ++++++++++++------
  kernel/time/sched_clock.c   | 111 
++++++++++++++++++++++++--------------------
  4 files changed, 95 insertions(+), 65 deletions(-)
