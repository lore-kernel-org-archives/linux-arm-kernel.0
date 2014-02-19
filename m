From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Feb 2014 17:05:24 -0300
Subject: [PATCH 0/2] Make Armada 370/XP and Orion clocksource use atomic I/O
 API
Message-ID: <1392840326-29417-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orion and armada-370-xp clocksource drivers are used in SoCs that can
use the orion-watchdog driver.

On these SoCs, the watchdog and timer blocks are part of the same set of
registers, and in particular the "control" register is used to enable/disable
both the watchdog and the timer.

Therefore, just as was done for orion-watchdog, we need to access the shared
register using the atomic I/O API.

This is v3.15 material, and meant to be merged through the clocksource tree,
if at all possible.

The first patch was already sent previously, but I'm resending it here to keep
the two patches together.

Thanks!

Ezequiel Garcia (2):
  clocksource: orion: Use atomic access for shared registers
  clocksource: armada-370-xp: Use atomic access for shared registers

 drivers/clocksource/time-armada-370-xp.c | 12 ++++--------
 drivers/clocksource/time-orion.c         | 28 ++++++++++------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

-- 
1.8.1.5
