From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 26 Aug 2016 16:20:22 +0200
Subject: [PULL] clockevents/clocksource fixes for 4.8-rc3
Message-ID: <57C05026.7010905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Thomas, Ingo,

this is the second round of fixes for 4.8-rc3.

 - Add the mck clock enablement for the ETM/ETB driver (Alexandre Belloni)

 - Clear the interrupts after stopping the timer in order to prevent
spurious interrupt at init time (Chen-Yu Tsai)

 - Fix a memory corruption on pistachio by replacing a reference to
pointer by the pointer itself (Marcin Nowakowski)

Thanks !

  -- Daniel

The following changes since commit aa8c0f1ad7e862147f4efb32bbb71ff66eb38caa:

  clocksource/drivers/pxa: Fix include files for compilation (2016-08-24
11:16:38 +0200)

are available in the git repository at:

  http://git.linaro.org/people/daniel.lezcano/linux.git
clockevents/4.8-fixes

for you to fetch changes up to b53e7d000d9e6e9fd2c6eb6b82d2783c67fd599e:

  clocksource/drivers/sun4i: Clear interrupts after stopping timer in
probe function (2016-08-26 15:56:01 +0200)

----------------------------------------------------------------
Alexandre Belloni (1):
      clocksource/drivers/timer-atmel-pit: Enable mck clock

Chen-Yu Tsai (1):
      clocksource/drivers/sun4i: Clear interrupts after stopping timer
in probe function

Marcin Nowakowski (1):
      drivers/clocksource/pistachio: Fix memory corruption in init

 drivers/clocksource/sun4i_timer.c     | 9 ++++++++-
 drivers/clocksource/time-pistachio.c  | 8 ++++----
 drivers/clocksource/timer-atmel-pit.c | 6 ++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
