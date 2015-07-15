From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 15 Jul 2015 14:36:54 +0200 (CEST)
Subject: [PATCH] irqchip: omap-intc: improve IRQ handler
In-Reply-To: <20150715064923.GA17550@atomide.com>
References: <1420224433-27001-1-git-send-email-balbi@ti.com>
 <20150119213458.GK18552@atomide.com> <20150715064923.GA17550@atomide.com>
Message-ID: <alpine.DEB.2.11.1507151435480.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jul 2015, Tony Lindgren wrote:
> Felipe,
> 
> * Tony Lindgren <tony@atomide.com> [150119 13:41]:
> > * Felipe Balbi <balbi@ti.com> [150102 10:50]:
> > > as it turns out the current IRQ number will
> > > *always* be available from SIR register which
> > > renders the reads of PENDING registers as plain
> > > unnecessary overhead.
> > > 
> > > In order to catch any situation where SIR reads
> > > as zero, we're adding a WARN() to turn it into
> > > a very verbose error and users actually report
> > > it.
> > > 
> > > With this patch average running time of
> > > omap_intc_handle_irq() reduced from about 28.5us
> > > to 19.8us as measured by the kernel function
> > > profiler.
> > > 
> > > Tested with BeagleBoneBlack Rev A5C.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > 
> > Jason, looks like this is not showing up in Linux next. The
> > same for the changes I did for dm81xx.
> 
> Can you please resend this to Jason? Looks like this
> is still not merged.

Please send it to me asap and please cc lkml on irqchip patches.

Thanks,

	tglx
