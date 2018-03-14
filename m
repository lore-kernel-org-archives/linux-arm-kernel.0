From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 11:09:56 +0000
Subject: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
In-Reply-To: <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
Message-ID: <a709e416-4024-f804-b2ff-ae6c2171a7c8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Radoslaw,

On 23/02/18 08:42, Thomas Gleixner wrote:
> Radoslaw,
> 
> On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:
> 
>> - discards setting handle_simple_irq handler for hierarchy interrupts
>> - removes acking in chained irq handler as this is done by
>> irq_chip itself inside handle_edge_irq
>> - removes unneeded irq_domain_ops.xlate callback
> 
> if that's all functionally correct, then this is a nice cleanup. Though
> from the above changelog its hard to tell because it merily tells WHAT the
> patch does, but not WHY. The WHY is the important information for a
> reviewer who is not familiar with the particular piece of code/hardware.
> 
> Can you please amend the changelog with proper explanations why a
> particular piece of code is not needed or has to be changed to something
> else?

Any update on this? I'd like to queue this for 4.17, but Thomas'
comments should be addressed before that happens. Ca you please respin a
version with a better change log and the various review tags?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
