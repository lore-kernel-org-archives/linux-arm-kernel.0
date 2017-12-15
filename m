From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 15 Dec 2017 09:52:43 +0100
Subject: [PATCH 0/4] stm32 clocksource driver rework
Message-ID: <20171215085247.14946-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

version 10:
 - do not remove 16 bits timer support
 - use prescaler to get a 10KHz clock

version 9:
 - rebased on timer/master where timer_of_cleanup() exist
 - fix the comments done by Daniel on v8
 - reword commits message to be more explicit about 16 bits counter issue
 - add one patch about copyrights and licences
   
version 8:
 - rebased on timers/core
 - change timer_of_exit() name to timer_of_cleanup()
 - update stm32 clocksource driver to use this function

version 7:
 - reword "clocksource: stm32: only use 32 bits timers" commit message
   to give more details about why 16 bits are problematics.

version 6:
 - add dedicated patch min delta change
 - rework commit messages, I hope it will be better now
 - change new function name from timer_of_deinit to timer_of_exit
 - make stm32_clock_event_set_next_event() safer like done in other
   drivers

version 6:
- add timer_of_deinit function in core
- rework failure cases in probe function

version 5:
- rebase on top of timer/core branch
- rework commit message of the first patch

version 4:
- split patch in 3 parts
  - convert code to timer_of
  - only use 32 bits timers
  - add clocksource support

version 3:
- fix comments done by Daniel
- use timer_of helper functions

version 2:
- fix uninitialized variable


Benjamin Gaignard (4):
  clocksource: stm32: convert driver to timer_of
  clocksource: stm32: use prescaler to adjust the resolution
  clocksource: stm32: add clocksource support
  clocksource: stm32: Update license and copyright

 drivers/clocksource/Kconfig       |   1 +
 drivers/clocksource/timer-stm32.c | 258 +++++++++++++++++++++-----------------
 2 files changed, 146 insertions(+), 113 deletions(-)

-- 
2.15.0
