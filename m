From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Nov 2014 14:06:12 +0100
Subject: [GIT PULL] clockevents: new material for 3.19
Message-ID: <5475D044.5060607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Thomas,

This pull request contains the following changes:

  * Ezequiel Garcia added the missing 'clock_enabled' calls before 
getting the clocks' rate, switched to the reference clock for both the 
timer and the watchdog on a37, and updated the DT bindings documentation 
accordingly

  * Yanchang Li removed the hard coded clock rate and let use the 
configurable one

Thanks !

   -- Daniel


The following changes since commit 867f667fb9c6734e06cc24e96fc7f06a7e772084:

   Merge tag 'renesas-clocksource-for-v3.18' of 
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into 
clockevents/3.18 (2014-09-29 01:59:51 +0200)

are available in the git repository at:


   http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/3.19

for you to fetch changes up to 4a22d9c93af1f2b2c40354c4bc59fd007f33f05e:

   clocksource: armada-370-xp: Use the reference clock on A375 SoC 
(2014-11-26 13:51:08 +0100)

----------------------------------------------------------------
Ezequiel Garcia (3):
       clocksource: armada-370-xp: Add missing clock enable
       watchdog: orion: Use the reference clock on Armada 375 SoC
       clocksource: armada-370-xp: Use the reference clock on A375 SoC

Yanchang Li (1):
       clocksource: sirf: Remove hard-coded clock rate

 
Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt 
|  9 ++++++---
  Documentation/devicetree/bindings/watchdog/marvel.txt 
   | 13 +++++++++++++
  drivers/clocksource/time-armada-370-xp.c 
   | 30 ++++++++++++++++++++++++++++++
  drivers/clocksource/timer-marco.c 
   | 23 +++++++++--------------
  drivers/watchdog/orion_wdt.c 
   | 42 +++++++++++++++++++++++++++++++++++++++++-
  5 files changed, 99 insertions(+), 18 deletions(-)


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
