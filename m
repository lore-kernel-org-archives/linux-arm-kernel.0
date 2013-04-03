From: horms@verge.net.au (Simon Horman)
Date: Wed, 3 Apr 2013 16:46:05 +0900
Subject: [PATCH v3 1/2] irqchip: intc-irqpin: Add support for shared
 interrupt lines
In-Reply-To: <CABYn4sx_pRxgdM3kD3okmt8xbCFas+T0cczQO=RF75Q8Bt2e_Q@mail.gmail.com>
References: <1364296699-20919-1-git-send-email-hechtb+renesas@gmail.com>
 <20130327045942.GH25431@verge.net.au>
 <CABYn4sx_pRxgdM3kD3okmt8xbCFas+T0cczQO=RF75Q8Bt2e_Q@mail.gmail.com>
Message-ID: <20130403074604.GC30989@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 02:50:05PM +0100, Bastian Hecht wrote:
> Hi Simon,
> 
> 2013/3/27 Simon Horman <horms@verge.net.au>:
> > On Tue, Mar 26, 2013 at 12:18:18PM +0100, Bastian Hecht wrote:
> >> On some hardware we don't have a 1-1 mapping from the external
> >> interrupts coming from INTC to the GIC SPI pins. We can however
> >> share lines to demux incoming IRQs on these SoCs.
> >>
> >> This patch enables the intc_irqpin driver to detect requests for shared
> >> interrupt lines and demuxes them properly by querying the INTC INTREQx0A
> >> registers.
> >>
> >> If you need multiple shared intc_irqpin device instances, be sure to mask
> >> out all interrupts on the INTC that share the one line before you start
> >> to register them. Else you run into IRQ floods that would be caused by
> >> interrupts for which no handler has been set up yet when the first
> >> intc_irqpin device is registered.
> >>
> >> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> >> Acked-by: Magnus Damm <damm@opensource.se>
> >
> > Thanks, I will see about queuing up these changes for v3.10.
> >
> >
> > I believe that with these changes it should be possible to rebase/rework
> > armadillo800eva-reference so that it no longer uses the unmerged INTC
> > DT bindings. Would it be possible for you to see about making a fresh
> > version of armadillo800eva-reference that is based on the next branch
> > in the Renesas tree plus this series of two patches?
> 
> yes ok, I'll prepare a new armadillo reference version. The patches
> were based on all+next, but I'll post a v4 rebased on next.
> I'll post a separate patch series for the reference code if you don't
> mind, as this might take a few days to be done.

Hi Bastian,

gentle nudge with regards to a fresh armadillo-reference.
