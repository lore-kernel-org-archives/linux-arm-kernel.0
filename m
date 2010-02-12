From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Feb 2010 10:40:41 +0100
Subject: at91 preempt oops
In-Reply-To: <c785bba31002110856m4c1068cr47a476742c2c4562@mail.gmail.com>
References: <c785bba31002110856m4c1068cr47a476742c2c4562@mail.gmail.com>
Message-ID: <20100212094041.GB21947@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

can you please reproduce with the patch below and then report that to
the maintainer of the reported function?

Best regards
Uwe

diff --git a/kernel/timer.c b/kernel/timer.c
index 15533b7..1dea19c 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1027,7 +1027,7 @@ static inline void __run_timers(struct tvec_base *base)
 				lock_map_release(&lockdep_map);
 
 				if (preempt_count != preempt_count()) {
-					printk(KERN_ERR "huh, entered %p "
+					printk(KERN_ERR "huh, entered %pF "
 					       "with preempt_count %08x, exited"
 					       " with %08x?\n",
 					       fn, preempt_count,

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
