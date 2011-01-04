From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 17:33:01 +0000
Subject: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
In-Reply-To: <20110104140031.GE25121@pengutronix.de>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
	<1294142577-28772-3-git-send-email-balbi@ti.com>
	<20110104140031.GE25121@pengutronix.de>
Message-ID: <20110104173301.GA25976@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 03:00:31PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Jan 04, 2011 at 02:02:55PM +0200, Felipe Balbi wrote:
> > GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
> > so it's safe to drop the duplicated entry and simply
> > select HAVE_GENERIC_HARDIRQS.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/Kconfig |    8 +-------
> >  1 files changed, 1 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index d56d21c0..e6f0f8b 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -15,6 +15,7 @@ config ARM
> >  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> >  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
> >  	select HAVE_GENERIC_DMA_COHERENT
> > +	select HAVE_GENERIC_HARDIRQS
> >  	select HAVE_KERNEL_GZIP
> >  	select HAVE_KERNEL_LZO
> >  	select HAVE_KERNEL_LZMA
> > @@ -88,10 +89,6 @@ config MCA
> >  	  <file:Documentation/mca.txt> (and especially the web page given
> >  	  there) before attempting to build an MCA bus kernel.
> >  
> > -config GENERIC_HARDIRQS
> > -	bool
> > -	default y
> > -
> >  config STACKTRACE_SUPPORT
> >  	bool
> >  	default y
> > @@ -171,9 +168,6 @@ config FIQ
> >  config ARCH_MTD_XIP
> >  	bool
> >  
> > -config GENERIC_HARDIRQS_NO__DO_IRQ
> > -	def_bool y
> > -
> You didn't mention this change in the commit log.  Is this duplicated,
> too or did it just slip through?

If you look at kernel/irq/Kconfig (as I did with the original patch)
you'd notice kernel/irq/Kconfig defines both of these symbols being
removed when HAVE_GENERIC_HARDIRQS is enabled.

If you read the discussion in the previous version of this patch set,
you'd notice that the removal of this was specifically requested.

It's very tiresome to have to re-explain these things.  Please take
some more time to research the points you bring up, rather than
impulse-replying.
