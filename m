From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 07 Oct 2011 18:18:52 -0400 (EDT)
Subject: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
In-Reply-To: <20111007205145.GA2293@atomide.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
	<4E5636CD.4080302@ti.com>
	<CANfBPZ-AAZx9TxO88EgxCtOUsWrsYzbK+M2d6cVSS7Kf-LwS3w@mail.gmail.com>
	<20111006195016.GM6324@atomide.com>
	<alpine.LFD.2.02.1110071612380.6390@xanadu.home>
	<20111007205145.GA2293@atomide.com>
Message-ID: <alpine.LFD.2.02.1110071814360.6390@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Oct 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [111007 12:41]:
> > On Thu, 6 Oct 2011, Tony Lindgren wrote:
> > 
> > > * S, Venkatraman <svenkatr@ti.com> [110825 07:23]:
> > > > On Thu, Aug 25, 2011 at 5:19 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > > > > Hi Venkat,
> > > > >
> > > > > On 8/24/2011 9:46 PM, S, Venkatraman wrote:
> > > > >>
> > > > >> As part of an effort to get single ARM kernel binary [1],
> > > > >> multiple ?definitions of NR_IRQS under various platforms
> > > > >> have to be reconciled and abstracted away from common code.
> > > > >>
> > > > >> This patch series takes the small step of populating the
> > > > >> machine descriptors with the pre-existing nr_irqs field.
> > > > >> Eventually, the common irq handler code will only look at this
> > > > >> field and not the compile time constant.
> > > > >
> > > > > Not related to this patch, but still on that topic. The current NR_IRQS
> > > > > depends as well on board stuff, like for example : the Phoenix
> > > > > IRQs:TWL6030_IRQ_BASE, TWL6040_CODEC_IRQ_BASE.
> > > > > Is there a plan to get rid of this static defines?
> > > > >
> > > > 
> > > > Currently, the goal is to get rid of the singleton nature
> > > > of NR_IRQS. Then it just becomes a property of the
> > > > platform, and the arm common code should not see this define.
> > > > This cleanup has to be done across multiple SoCs, not just OMAP.
> > > > 
> > > > After I get to complete some meaningful cleanup of NR_IRQS,
> > > > I can look into the static defines that you mention.
> > > 
> > > I suggest we wait on this patch as the NR_IRQS should be the
> > > board specific true number of interrupts including chained
> > > interrupts from external devices like twl. So just setting
> > > it to NR_IRQS does not help much. Also, the board-*.c files
> > > will be going aways with device tree at some point.
> > 
> > This is prerequisite to some other cleanup orthogonal to DT being worked 
> > in parallel.  I would prefer if DT wasn't a serialization point for 
> > this.
> 
> I see. How about let's populate the real number of interrupts for the
> known boards then while at it.

Sure, if you know what you are doing (which I'm sure you do).  
Otherwise using NR_IRQS is more or less a functional no-op wrt the 
current situation, and therefore what I would have used myself because I 
don't know much about the various OMAP boards.


Nicolas
