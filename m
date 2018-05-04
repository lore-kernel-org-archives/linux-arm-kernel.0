From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2018 08:21:37 -0700
Subject: [PATCH] arm: Convert arm boot_lock to raw
In-Reply-To: <20180504105600.20613-1-bigeasy@linutronix.de>
References: <20180504105600.20613-1-bigeasy@linutronix.de>
Message-ID: <20180504152137.GC98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180504 10:58]:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> The arm boot_lock is used by the secondary processor startup code.  The locking
> task is the idle thread, which has idle->sched_class == &idle_sched_class.
> idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
> lock, the attempt to wake it when the lock becomes available will fail:
> 
> try_to_wake_up()
>    ...
>       activate_task()
>          enqueue_task()
>             p->sched_class->enqueue_task(rq, p, flags)
> 
> Fix by converting boot_lock to a raw spin lock.

Still works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
