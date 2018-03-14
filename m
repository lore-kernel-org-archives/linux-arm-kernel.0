From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 12:04:50 +0000
Subject: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
In-Reply-To: <CAFvLkMSZjgFMAe0VRc0AEpG89BgXkfMb9+ivJ8V+PFighOoDRA@mail.gmail.com>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
 <a709e416-4024-f804-b2ff-ae6c2171a7c8@arm.com>
 <CAFvLkMSZjgFMAe0VRc0AEpG89BgXkfMb9+ivJ8V+PFighOoDRA@mail.gmail.com>
Message-ID: <118e66b4-3137-7af5-b93d-b1949fad575c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/18 11:46, Rados?aw Pietrzyk wrote:
> Hi Marc,
> We had a quite fruitful discussion in this mail thread regarding this
> topic and Ludovic acked it so recently I have asked Thomas if he still
> needs this v3 patch with detailed explanation especially as v2 version
> of stm32-gpio patch has been already taken by Linus. However if you
> require I can resend v3 of this patch only with this detailed explanation.

That'd be useful. The changelog is the only thing that will be left from
this discussion, so it'd better be complete and accurate. If you quickly
send a v3 for this single patch, I'll queue it right away.

Thanks,

	M.

> 
> 2018-03-14 12:09 GMT+01:00 Marc Zyngier <marc.zyngier@arm.com
> <mailto:marc.zyngier@arm.com>>:
> 
>     Radoslaw,
> 
>     On 23/02/18 08:42, Thomas Gleixner wrote:
>     > Radoslaw,
>     >
>     > On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:
>     >
>     >> - discards setting handle_simple_irq handler for hierarchy interrupts
>     >> - removes acking in chained irq handler as this is done by
>     >> irq_chip itself inside handle_edge_irq
>     >> - removes unneeded irq_domain_ops.xlate callback
>     >
>     > if that's all functionally correct, then this is a nice cleanup. Though
>     > from the above changelog its hard to tell because it merily tells WHAT the
>     > patch does, but not WHY. The WHY is the important information for a
>     > reviewer who is not familiar with the particular piece of code/hardware.
>     >
>     > Can you please amend the changelog with proper explanations why a
>     > particular piece of code is not needed or has to be changed to something
>     > else?
> 
>     Any update on this? I'd like to queue this for 4.17, but Thomas'
>     comments should be addressed before that happens. Ca you please respin a
>     version with a better change log and the various review tags?
> 
>     Thanks,
> 
>     ? ? ? ? M.
>     --
>     Jazz is not dead. It just smells funny...
> 
> 


-- 
Jazz is not dead. It just smells funny...
