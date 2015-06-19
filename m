From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Jun 2015 15:25:52 +0000
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <d6d361113992920900137899ae4d1f7b@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434446447.4785.7.camel@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
 <1434677895.4767.11.camel@dolka.fr> <5583DD23.90505@arm.com>
 <1434716194.17448.28.camel@x60s>
 <20150619131315.GR7557@n2100.arm.linux.org.uk>
 <d6d361113992920900137899ae4d1f7b@dolka.fr>
Message-ID: <20150619152552.GF2936@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 03:46:45PM +0200, Benjamin Cama wrote:
> Le 2015-06-19 15:13, Russell King - ARM Linux a ??crit??:
> >On Fri, Jun 19, 2015 at 02:16:34PM +0200, Benjamin Cama wrote:
...
> >>I was not talking about the irq handler, but the irq initialization
> >>routine (on orion5x, orion_irq_init calls irq_alloc_generic_chip
> >>with 0), which takes the starting irq number and may warn when it is
> >>zero (well, it may also start allocating at zero but never use it,
> >>so this may not be a totally correct assumption, but I think this
> >>comes close, and it's just a warning).
> >
> >It needs fixing nevertheless - arguments along the lines of "this
> >used to work" don't work for this topic.
> >
> >The simple answer is to adjust the initialisation to bump the IRQ
> >numbers up by one, and them adjust the interrupt numbers in
> >arch/arm/mach-whatever/include/asm/irqs.h also up by one.  That's
> >far easier to do than spending ages trying to argue against the
> >"IRQ0 is not valid" issue, only to ultimately get nowhere, and end
> >up with that as the only way forward anyway.
> 
> Do not misunderstand me: I am not at all for keeping the situation
> like this!  What I ask is just for users to be notified of this new
> requirement: for my case, my board simply couldn't boot anymore,
> without any explanation. If there was a message along the lines ???You
> are setting up IRQs starting from 0, which is not supported by the
> kernel anymore??? just before crashing, maybe it would help debugging
> the issue.
> 
> I could try to write a patch for it, but I was first wondering if this
> is a good idea or not.

Let's just get the dts patch reviewed and merged first.  Russell
actually wrote the patch to do what he's describing for mach-dove.

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309684.html

Although, it looks like it never got updated for submission...

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311800.html

thx,

Jason.
