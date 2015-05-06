From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 May 2015 11:37:37 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150506101850.GE2067@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408173656.GF5977@leverpostej>
 <20150408175533.GN12732@n2100.arm.linux.org.uk>
 <552C14F0.7020006@oracle.com> <20150415120738.GD2866@leverpostej>
 <552E9F9B.2040400@oracle.com> <20150423112449.GB17361@leverpostej>
 <20150506101850.GE2067@n2100.arm.linux.org.uk>
Message-ID: <20150506103736.GA707@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> > It turns out that I was incorrect in my assertion, and the reordering I
> > suggested above can't happen. The ARMv7 ARM states:
> > 
> > 	Any direct write to a system control register is guaranteed not
> > 	to affect any instruction that appears, in program
> > 	order, before the instruction that performed the direct write
> > 
> > Which means that the STMFD cannot be affected by the later cp15 write to
> > the SCTLR, and so the DSB does not need to be moved before the MCR.
> > 
> > I apologise for adding to the confusion there.
> 
> So does this mean this patch gets an ack now?

I assumed there was going to be a respin for the CR_W change?

There's also the dodginess w.r.t. the page table walkers that I can't
see is solvable short of disabling the MMU prior to the flush, though I
understand you've NAKed that approach.

Thanks,
Mark.
