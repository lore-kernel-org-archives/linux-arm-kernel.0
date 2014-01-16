From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 Jan 2014 11:53:47 -0500
Subject: [PATCH] ARM: orion: provide C-style interrupt handler for
 MULTI_IRQ_HANDLER
In-Reply-To: <1389891087.6697.26.camel@kazak.uk.xensource.com>
References: <1389775235.10695.51.camel@dagon.hellion.org.uk>
 <1389859831-9883-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140116164833.GH29184@titan.lakedaemon.net>
 <1389891087.6697.26.camel@kazak.uk.xensource.com>
Message-ID: <20140116165347.GI29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 04:51:27PM +0000, Ian Campbell wrote:
> On Thu, 2014-01-16 at 11:48 -0500, Jason Cooper wrote:
> > Sebastian,
> > 
> > On Thu, Jan 16, 2014 at 09:10:31AM +0100, Sebastian Hesselbarth wrote:
> > > DT-enabled Marvell Kirkwood and Dove SoCs make use of an irqchip
> > > driver. As expected for irqchip drivers, it uses a C-style
> > > interrupt handler and therefore selects MULTI_IRQ_HANDLER.
> > > 
> > > Now, compiling a kernel with both non-DT and DT support enabled,
> > > selecting MULTI_IRQ_HANDLER will break ASM irq handler used by
> > > non-DT boards.
> > > 
> > > Therefore, we provide a C-style irq handler even for non-DT boards,
> > > if MULTI_IRQ_HANDLER is set. By installing the C-style irq handler
> > > in orion_irq_init this is transparent to all non-DT board files.
> > > 
> > > While the regression report was filed on Marvell Kirkwood, also
> > > Marvell Dove non-DT boards are affected and fixed by this patch.
> > > 
> > > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > Tested-by: Ian Campbell <ijc@hellion.org.uk>
> > > Reported-by: Ian Campbell <ijc@hellion.org.uk>
> > > Fixes: 2326f04321a9 ("ARM: kirkwood: convert to DT irqchip and clocksource")
> > > Fixes: f07d73e33d0e ("ARM: dove: convert to DT irqchip and clocksource")
> > > ---
> > > Compared to the two patch version sent on Ian's regression report,
> > > I cooked this down to a single patch only touching plat-orion/irq.c.
> > > I also dropped Orion5x and MV78x00, as they not yet select MULTI_IRQ_HANDLER
> > > at all. Instead I added a comment about taking care of them, as soon as
> > > they move over to an irqchip driver themselves.
> > > 
> > > I have not yet Cc'ed this patch to -stable to get some discussion and
> > > an Acked-by from Jason or Andrew, too.
> > > 
> > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Ian Campbell <ijc@hellion.org.uk>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: linux-kernel at vger.kernel.org
> > > ---
> > >  arch/arm/plat-orion/irq.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > 
> > Applied to mvebu/fixes with Andrew's Ack.  It's too late for v3.13, so
> > it'll be the first thing sent for v3.14.
> 
> Please can it also be tagged for stable backport to 3.12+3.13.

Yes, I forgot to mention it, but that is already done. ;-)

thx,

Jason.
