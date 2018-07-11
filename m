From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 Jul 2018 12:24:23 +0100
Subject: [PATCH 2/3] tick: broadcast-hrtimer: use cpu_possible_mask for
 ce_broadcast_hrtimer
In-Reply-To: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1531308264-24220-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the last instance of cpu_all_mask usage in the core framework.
Lets replace it with cpu_possible_mask like all other instances in the
clockevent drivers. This will now enable us to add warning in the core
clockevents_register_device on usage of cpu_all_mask from any clockevent
drivers in future.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 kernel/time/tick-broadcast-hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 58045eb976c3..a59641fb88b6 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -90,7 +90,7 @@ static struct clock_event_device ce_broadcast_hrtimer = {
 	.max_delta_ticks	= ULONG_MAX,
 	.mult			= 1,
 	.shift			= 0,
-	.cpumask		= cpu_all_mask,
+	.cpumask		= cpu_possible_mask,
 };

 static enum hrtimer_restart bc_handler(struct hrtimer *t)
--
2.7.4
