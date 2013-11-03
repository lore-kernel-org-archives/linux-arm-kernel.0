From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sun,  3 Nov 2013 18:52:41 +0100
Subject: [PATCH 0/3] watchdog: at91sam9_wdt: various fixes and improvements
Message-ID: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fix the secs_to_ticks macro in case 0 is passed as an
argument.

It also rework the heartbeat calculation to increase the security margin of the
watchdog reset timer, and use the min_heartbeat value instead of the calculated
heartbeat value for the first watchdog reset (to avoid spurious watchdog
reset).

Best Regards,

Boris

Boris BREZILLON (3):
  watchdog: at91sam9_wdt: fix secs_to_ticks
  watchdog: at91sam9_wdt: avoid spurious watchdog reset during init
  watchdog: at91sam9_wdt: increase security margin on watchdog counter
    reset

 drivers/watchdog/at91sam9_wdt.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

-- 
1.7.9.5
