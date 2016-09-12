From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 12 Sep 2016 11:10:21 +0200
Subject: [PULL] clockevents for 4.9
Message-ID: <b04803ca-5506-bf69-04df-f28efbc9a94a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Thomas, Ingo,

This pull request for 4.9 contains a few changes:

 - Cleanup the atmel-pit timer (Alexander Belloni)

 - Add the Aspeed support (Joel Stanley)

 - Replaced setup_irq/request_irq and panic/pr_err on moxart (Daniel
Lezcano)

 - Add the Ox820 compatible string for oxnas (Neil Armstrong)

Thanks !

  -- Daniel


The following changes since commit 950d8381d915ee293a5b57f91e59dd8115684af1:

  Merge branch 'linus' into timers/core, to refresh the branch
(2016-09-08 14:05:16 +0200)

are available in the git repository at:

  http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.9

for you to fetch changes up to 2ea3401e2a84eed3f5f55b2075706f88df160d85:

  clocksource/drivers/oxnas: Add OX820 compatible (2016-09-12 07:28:46
+0200)

----------------------------------------------------------------
Alexandre Belloni (3):
      clocksource/drivers/timer-atmel-pit: Drop at91sam926x_pit_common_init
      clocksource/drivers/timer-atmel-pit: Remove uselesss WARN_ON_ONCE
      clocksource/drivers/timer-atmel-pit: Simplify IRQ handler

Daniel Lezcano (2):
      clocksource/drivers/moxart: Replace setup_irq by request_irq
      clocksource/drivers/moxart: Replace panic by pr_err

Joel Stanley (3):
      clocksource/drivers/moxart: Refactor enable/disable
      clocksource/drivers/moxart: Use struct to hold state
      clocksource/drivers/moxart: Add Aspeed support

Neil Armstrong (1):
      clocksource/drivers/oxnas: Add OX820 compatible

 Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt |   4 +++-
 Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt  |   2 +-
 drivers/clocksource/moxart_timer.c                            | 193
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------
 drivers/clocksource/timer-atmel-pit.c                         |  96
+++++++++++++++++++++++++++++++++++++-----------------------------------------------------------
 drivers/clocksource/timer-oxnas-rps.c                         |   2 ++
 5 files changed, 172 insertions(+), 125 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
