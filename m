From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jul 2016 14:50:29 +0100
Subject: [PATCH 1/2] arm-ccn: ensure perf synchronisation
In-Reply-To: <1467639584.22236.1.camel@arm.com>
References: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
 <1467136218-15789-2-git-send-email-mark.rutland@arm.com>
 <1467639584.22236.1.camel@arm.com>
Message-ID: <20160704135029.GB9048@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 02:39:44PM +0100, Pawel Moll wrote:
> Dnia 2016-06-28, Tue o godzinie 18:50 +0100, Mark Rutland pisze:
> > Currently the IRQ core is permitted to make the CCN PMU IRQ handler
> > threaded, and will allow userspace to change the CPU affinity of the
> > interrupt behind our back. Both of these could violate our
> > synchronisation requirements with the core perf code, which relies upon
> > strict CPU affinity and disabling of interrupts to guarantee mutual
> > exclusion in some cases.
> > 
> > As with the CPU PMU drivers, we should request the interrupt with
> > IRQF_NOBALANCING and IRQF_NO_THREAD, to avoid these issues.
> 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers. I've just sent v2, so I've applied that locally, and it'll
appear if a v3 is necessary.

> In principle, because still had no chance to test it...

Understood.

Thanks,
Mark.
