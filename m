From: baijiaju1990@gmail.com (Jia-Ju Bai)
Date: Tue, 12 Dec 2017 17:52:04 +0800
Subject: [BUG] atmel_ssc_dai: a possible sleep-in-atomic bug in
 atmel_ssc_shutdown
Message-ID: <59796efc-8acd-6655-cf59-67c162201bd7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to sound/soc/atmel/atmel_ssc_dai.c, the driver may sleep under 
a spinlock.
The function call path is:
atmel_ssc_shutdown (acquire the spinlock)
   free_irq --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and checked 
by my code review.


Thanks,
Jia-Ju Bai
