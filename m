From: v1ron@mail.ru (Roman Volkov)
Date: Thu, 31 Dec 2015 21:02:04 +0300
Subject: [PATCH v2 RESEND 0/3] clocksource/vt8500: Fix hangs in small delays
Message-ID: <1451584927-4051-1-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

vt8500 hangs in nanosleep() function, starting from commit
c6eb3f70d4482806dc2d3e1e3c7736f497b1d418, making the system unusable.
Per investigation, looks like set_next_event() now receives too small
delta and fails with -ETIME.

Google group discussion:
https://groups.google.com/forum/#!topic/vt8500-wm8505-linux-kernel/vDMF_mDOb1k

v2:
Address comments by Alexey Charkov. Merge patches to get less amount of
changes (three patches instead of four).

Tested on my WM8650, no issues in three days uptime.

Roman Volkov (3):
  clocksource/vt8500: Use MIN_OSCR_DELTA from PXA
  clocksource/vt8500: Remove the 'loops' variable
  clocksource/vt8500: Add register R/W functions

 drivers/clocksource/vt8500_timer.c | 98 +++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 29 deletions(-)

-- 
2.6.2
