From: wbarak@gmail.com (Barak Wasserstrom)
Date: Thu, 20 Sep 2012 19:22:28 +0300
Subject: GIC affinity and edge trigger
Message-ID: <CC811D74.ECFF%wbarak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I'm currently using linux kernel 2.6.38 with SMP enabled.
I have an interrupt which is a pulse and therefore I set the trigger to
positive edge.
Due to the fact that each CPU sees its own GIC distributor memory space,
only the CPU that executed request_irq has the trigger type set to positive
edge, while the others remain level.
Moreover, gic_set_cpu always defines the GIC distributor target to be CPU0.
So only CPU0 target is enabled + trigger is set to edge only for one CPU and
thus not always do I get the interrupt.
Can you please help me understand what I'm doing wrong, or misunderstand?

Regards,
Barak



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120920/e56f20e7/attachment-0001.html>
