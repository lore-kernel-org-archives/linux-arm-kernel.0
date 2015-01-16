From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Jan 2015 14:11:09 +0000
Subject: [PATCH v5 2/5] Documentation: DT: Add bindings for Spreadtrum
 SoC Platform
In-Reply-To: <CAAfSe-teDdPzRUnvzM+NErfZwmqM04yUMgic--hyZL8-Jjd8jw@mail.gmail.com>
References: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150116102135.GC21809@leverpostej>
 <CAAfSe-teDdPzRUnvzM+NErfZwmqM04yUMgic--hyZL8-Jjd8jw@mail.gmail.com>
Message-ID: <20150116141109.GC22569@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 12:53:16PM +0000, Lyra Zhang wrote:
> Hi, Mark
> 
> >> +
> >> +Required properties:
> >> +- compatible: must be "sprd,sc9836-uart"
> >> +- reg: offset and length of the register set for the device
> >> +- interrupts: exactly one interrupt specifier
> >> +- clocks: phandles to input clocks.
> >
> > The order and relevance of each should be specified. If you have
> > multiple clocks I would strongly recommend you use clock-names to
> > distinguish them.
> >
> 
> Thank you for the recommendation.
> but, since we haven't made the clock driver ready, for this initial
> commit, we just let 4 UARTs share a single fixed 26 MHz clock source.
> we'll do like you've recommended when we will submit the clock driver
> in the future.

I'm on about the clock input lines on the UART instance, not the
providers they come from.

Is there only a single clock input line on each UART? Perhaps multiple
input lines which are currently fed by the same clock?

Thanks,
Mark.
