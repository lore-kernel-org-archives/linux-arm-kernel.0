From: vichy.kuo@gmail.com (vichy)
Date: Fri, 21 Aug 2015 01:09:23 +0800
Subject: is it possible to liimit the softirq re entrance times
Message-ID: <CAOVJa8FfHWGVf=ccXFCyTUD5YHrMAAeQ9Tkg1ipHA=J_CyVAHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After I tracing softirq flow in ARM platform, I have some colusion like below:
1. softirq is running at the end of any irq context, when irq is eabled.
2. as long as any Hard irq happen, softirq can be interrupt and reentrant

My question are:
1. in __do_sofiq, there is a jiffies setting to make sure the whole
softirq will not took to long.
But in my case is there any many hard irq happen like below

                        trace_softirq_entry(vec_nr);    ------a
                        h->action(h);
                        trace_softirq_exit(vec_nr);      ---------b

from lttng, I see there 100 interrupt happen from entry to exit.

is there kernel config or module parameter to let me down grade the
hard irq count from 100  --> 80 or 90 and event can controlled me.
I don't mean I control the count of hard irq, but I found this softirq
is interrupt by 80 times.
then I will not enable_irq until I finished the job.

if no, isn't it possible to make starvation in above a and b?

really appreciate ur kind help,
