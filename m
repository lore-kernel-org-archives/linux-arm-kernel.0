From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 Mar 2015 12:11:02 +0200
Subject: [GIT PULL] clockevents for 4.1 #2
Message-ID: <551A72B6.7030106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo, Thomas,

this is the second pull request with the different fixes. The sun5i 
timer conflict is fixed and the function name for arch arm timer is also 
fixed. So this second pull request contains the following:

  - Changed the arch_timer_probed function name to 
arch_timer_needs_probe to reflect better the behavior (Laurent Pinchart)

  - Used the freq changes notifiers to fix the rate alteration with the 
cpufreq driver as this one impacts the sun5i's parent clock (Maxime Ripard)

Thanks !

   -- Daniel

The following changes since commit 4806c87f017d8a7003ad34886f58c3b9e023df6a:

   clocksource/drivers/at91: Fix IO endianness (2015-03-31 09:15:58 +0200)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.1

for you to fetch changes up to 639793eb6552f3f5ce7db93e75aff57c1bad7a6b:

   clocksource/drivers/sun5i: Add clock notifiers (2015-03-31 11:50:06 
+0200)

----------------------------------------------------------------
Laurent Pinchart (1):
       clocksource/drivers/arm_arch_timer: Rename arch_timer_probed to 
reflect behaviour

Maxime Ripard (4):
       clocksource/drivers/sun5i: Switch to request_irq
       clocksource/drivers/sun5i: Use of_io_request_and_map
       clocksource/drivers/sun5i: Refactor the current code
       clocksource/drivers/sun5i: Add clock notifiers

  drivers/clocksource/arm_arch_timer.c |  13 +++++-----
  drivers/clocksource/timer-sun5i.c    | 302 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------
  2 files changed, 238 insertions(+), 77 deletions(-)

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
