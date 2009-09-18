From: schen@mvista.com (Steve Chen)
Date: Fri, 18 Sep 2009 16:51:49 -0500
Subject: [PATCH v3] arm: remove unused code in delay.S
In-Reply-To: <20090918205349.GM29905@game.jcrosoft.org>
References: <1253292418.3273.257.camel@linux-1lbu>
	<20090918190920.GB11461@pengutronix.de>
	<1253305534.3273.283.camel@linux-1lbu>
	<20090918205349.GM29905@game.jcrosoft.org>
Message-ID: <1253310710.3273.294.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-09-18 at 22:53 +0200, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> On 15:25 Fri 18 Sep     , Steve Chen wrote:
> > On Fri, 2009-09-18 at 21:09 +0200, Uwe Kleine-K?nig wrote:
...
> > > > +	def_bool n
> > > as already noted, n is the default (that would better be expressed using
> > > "default n" btw).
> > 
> > Jean-Christope/Uwe, I'll change it to "default n".
> simply remove it will be better

Sure, I can remove it altogether.

...
> > > > +	  ARM610 and ARM710 are known to benefit from enabling this option.
> > > > +	  It should not be enabled for StrongARMs, because it is known
> > > > +	  to produce too short delays on those.
> > > > +
> > > > +	  Lastly, below are 2 lists.  The first list contains the processors
> simply remove it will be better

Remove the entire last paragraph?  I guess the header of the list does
explain everything.  I'll remove it.

...
> > > 
> > > > +	  CPUs should enable this flag
> > > > +		ARM610
> > > > +		ARM710
> > > > +
> > > > +	  CPUs should disable this flag
> > > > +		StrongARM
> > > everything armv5+ ?
> IIRC StrongARM is armv4
> ARM610 & 710 is armv3

If all armv4 are StrongARM, I can just remove it from the "depends"
list.  I'll need some help confirming.  At this point, I'm not sure what
else to change in this list.

Thanks for the inputs.

Steve
