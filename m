From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 2 Jun 2010 15:06:29 +0200 (CEST)
Subject: [RFC PATCH] irq: handle private interrupt registration
In-Reply-To: <20100602054104.GE6465@nokia.com>
References: <1274905794-7848-1-git-send-email-adharmap@codeaurora.org>
	<20100601152652.9296c5d0.akpm@linux-foundation.org>
	<alpine.LFD.2.00.1006020110090.2933@localhost.localdomain>
	<20100602054104.GE6465@nokia.com>
Message-ID: <alpine.LFD.2.00.1006021504080.2933@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 2 Jun 2010, Felipe Balbi wrote:

> Hi,
> 
> On Wed, Jun 02, 2010 at 01:14:32AM +0200, ext Thomas Gleixner wrote:
> > 1) Use PER_CPU offsets for the irq numbers. The generic irq code does
> >   not care whether the interrupt number is matching any physical
> >   numbering scheme in the hardware, as long as the arch specific chip
> >   implementation knows how to deal with it, which is not rocket
> >   science to do.
> 
> FWIW, I think (1) is a better approach as the problem will vanish altogether
> and to me it sounds like the simpler approach as well. Archs which have more
> than one IRQ chip (like OMAP with the twl4030 family) will already use
> sequencial numbering anyway, so using the same approach for N cpus, to me,
> sounds like a good deal.
> 
> While at that, a question from my side: do we have a generic way of fetching
> the last IRQ number so we can easily use that to calculate the physical number
> of the IRQ line on the chip ?
> 
> On OMAP, we have been passing that number down to twl4030 via platform_data,
> but it would be better to ask genirq to tell us which was the last irq number
> "claimed".

No, we don't, but it might be a good idea to move the virq management
from powerpc into generic code so other archs can use it as
well. Needs some thought.

Thanks

	tglx


      
