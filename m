From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 5 Jul 2016 16:57:51 +0800
Subject: [PATCH] tick: broadcast-hrtimer: set name of the ce_broadcast_hrtimer
Message-ID: <1467709071-3667-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to avoid the "null" name when we either

~ # cat /sys/devices/system/clockevents/broadcast/current_device
(null)

or

~ # cat /proc/timer_list
...
Tick Device: mode:     1
Broadcast device
Clock Event Device: (null)
...

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 kernel/time/tick-broadcast-hrtimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 53d7184..690b797 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -75,6 +75,7 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 }
 
 static struct clock_event_device ce_broadcast_hrtimer = {
+	.name			= "bc_hrtimer",
 	.set_state_shutdown	= bc_shutdown,
 	.set_next_ktime		= bc_set_next,
 	.features		= CLOCK_EVT_FEAT_ONESHOT |
-- 
2.8.1
