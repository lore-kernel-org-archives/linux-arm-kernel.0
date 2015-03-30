From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Mar 2015 22:14:42 +0200
Subject: [GIT PULL] clockevents for 4.1
Message-ID: <5519AEB2.8050306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Thomas, Ingo,

this pull request contains the following changes for 4.1:

  - Made IO endian agnostic for at91 and dw apb timers (Ben Dooks)

  - Maintained tegra endianess (Dmitry Osipenko)

  - Enabled the sun4i / sun5i timer for sched_clock, all others winner 
boards have the arch arm timer which is more accurate (Hans de Goede)

  - Renamed the arch arm timer function name to reflect better its 
purpose (Laurent Pinchart)

  - Cleaned up the sun5i timer code, replaced the setup_irq by the 
request_irq function and handled the parent clock frequency change with 
the frequency notifiers (Maxime Ripard)

  - Fixed features declaration for the efm32 timer (Viresh Kumar)

Thanks !

   -- Daniel

The following changes since commit 2557d215a36d18c8bbaa35f65749349ac603360b:

   Merge branch 'timers/urgent' into timers/core, to pick up fixes 
before applying new changes (2015-03-17 11:11:24 +0100)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.1

for you to fetch changes up to 0bb4ef6f7c56cdf606a5e501cf1597f40c9028eb

   clocksource: efm32: Use CLOCK_EVT_FEAT_PERIODIC for defining features 
(2015-03-30 15:27:24 +0200)

----------------------------------------------------------------
Ben Dooks (2):
       clocksource: at91: Make IO endian agnostic
       clocksource: dw_apb_timer_of: Make IO endian agnostic

Dmitry Osipenko (1):
       clocksource: tegra: Maintain CPU endianness

Hans de Goede (1):
       clocksource: sun4i-timer: Only register a sched_clock on sun4i 
and sun5i

Laurent Pinchart (1):
       clocksource: arm_arch_timer: Rename arch_timer_probed to reflect 
behaviour

Maxime Ripard (5):
       clocksource: sun5i: Switch to request_irq
       clocksource: sun5i: Use of_io_request_and_map
       clocksource: sun5i: Remove sched_clock
       clocksource: sun5i: Refactor the current code
       clocksource: sun5i: Add clock notifiers

Viresh Kumar (1):
       clocksource: efm32: Use CLOCK_EVT_FEAT_PERIODIC for defining features

  drivers/clocksource/arm_arch_timer.c  |  13 +++++-----
  drivers/clocksource/dw_apb_timer_of.c |   2 +-
  drivers/clocksource/sun4i_timer.c     |  10 +++++++-
  drivers/clocksource/tegra20_timer.c   |   4 ++--
  drivers/clocksource/time-efm32.c      |   2 +-
  drivers/clocksource/timer-atmel-pit.c |   4 ++--
  drivers/clocksource/timer-sun5i.c     | 302 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------
  7 files changed, 250 insertions(+), 87 deletions(-)

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
