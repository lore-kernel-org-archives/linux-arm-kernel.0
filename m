From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 18 Sep 2009 22:53:49 +0200
Subject: [PATCH v3] arm: remove unused code in delay.S
In-Reply-To: <1253305534.3273.283.camel@linux-1lbu>
References: <1253292418.3273.257.camel@linux-1lbu>
	<20090918190920.GB11461@pengutronix.de>
	<1253305534.3273.283.camel@linux-1lbu>
Message-ID: <20090918205349.GM29905@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:25 Fri 18 Sep     , Steve Chen wrote:
> On Fri, 2009-09-18 at 21:09 +0200, Uwe Kleine-K?nig wrote:
> > Hello Steve,
> > 
> > On Fri, Sep 18, 2009 at 11:46:58AM -0500, Steve Chen wrote:
> > > Document #if 0 code block in delay.S and make it selectable for compile.
> > > 
> > > Signed-off-by: Steve Chen <schen@mvista.com>
> > > 
> > > ---
> > >  arch/arm/Kconfig     |   31 +++++++++++++++++++++++++++++++
> > >  arch/arm/lib/delay.S |    2 +-
> > >  2 files changed, 32 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index aef63c8..f44cb70 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -813,6 +813,37 @@ config ARM_ERRATA_460075
> > >  	  ACTLR register. Note that setting specific bits in the ACTLR
> > > register
> > >  	  may not be available in non-secure mode.
> > >  
> > > +config OLD_CPU_DELAY
> > > +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> > > +	bool "Different delay() code for some older CPUs"
> > > +	def_bool n
> > as already noted, n is the default (that would better be expressed using
> > "default n" btw).
> 
> Jean-Christope/Uwe, I'll change it to "default n".
simply remove it will be better

Best Regards,
J.
> 
> > 
> > > +	help
> > > +	  Enable this if observing longer than expected delays.  This code
> > > +	  improves delay accuracy for some CPUs.  However, it can also cause
> > > +	  delay duration to be too short for others which leads to stability
> > > +	  issues.
> > > +
> > > +	  In other words, do not enable unless you can guarantee that the
> > > +	  processor (or ALL of the processors if building a generic kernel)
> > > +	  delays for at least the time requested after enabling.
> > > +
> > > +	  ARM610 and ARM710 are known to benefit from enabling this option.
> > > +	  It should not be enabled for StrongARMs, because it is known
> > > +	  to produce too short delays on those.
> > > +
> > > +	  Lastly, below are 2 lists.  The first list contains the processors
simply remove it will be better

Best Regards,
J.> > > +	  that would benefit from enabling this flag, and the second list
> > > +	  contains processor that are known to have issues.  Please note that
> > > +	  both lists are by no means complete.  Entries are expected to be
> > > +	  added and refined.  If you like to update the list, please send a
> > > +	  patch to Linux ARM mailing list.
> > I'd delete the last three sentences.
> 
> Well, do.  Anything after "Entries are expected to be..." will be
> deleted.
> 
> > 
> > > +	  CPUs should enable this flag
> > > +		ARM610
> > > +		ARM710
> > > +
> > > +	  CPUs should disable this flag
> > > +		StrongARM
> > everything armv5+ ?
IIRC StrongARM is armv4
ARM610 & 710 is armv3

Best Regards,
J.
