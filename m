From: me@felipebalbi.com (Felipe Balbi)
Date: Tue, 04 Jan 2011 16:09:13 +0200
Subject: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
In-Reply-To: <20110104140031.GE25121@pengutronix.de>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
	<1294142577-28772-3-git-send-email-balbi@ti.com>
	<20110104140031.GE25121@pengutronix.de>
Message-ID: <1294150153.1822.10.camel@eowin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-04 at 15:00 +0100, Uwe Kleine-K?nig wrote:
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

Yes it is. My bad. Do I need to update the patch ? I can do it tomorrow.

-- 
balbi
