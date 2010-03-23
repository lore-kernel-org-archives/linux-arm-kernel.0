From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Mar 2010 17:09:28 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703045F314F@dbde02.ent.ti.com>
References: <20100320003605.GA11448@atomide.com>
	<20100320004746.GB11448@atomide.com>
	<20100320024827.GC11448@atomide.com>
	<20100320030239.GD11448@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608703045F314F@dbde02.ent.ti.com>
Message-ID: <20100323000927.GX11448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pandita, Vikram <vikram.pandita@ti.com> [100320 15:56]:
> 
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > Sent: Friday, March 19, 2010 10:03 PM
> > To: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> > Cc: Pais, Allen; Pandita, Vikram
> > Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
> > 
> > * Tony Lindgren <tony@atomide.com> [100319 19:43]:
> > > * Tony Lindgren <tony@atomide.com> [100319 17:42]:
> > > > * Tony Lindgren <tony@atomide.com> [100319 17:30]:
> > > > > Hi all,
> > > > >
> > > > > Got a zoom3 finally! This is needed to boot with DEBUG_LL +
> > earlyprintk.
> > > >
> > > > And of course it won't compile because of a missing #.
> > > > Here's the working version.
> > >
> > > One more time. Looks like what I posted is not enough, we
> > > also need to make sure the mapping does not overlap with
> > > other regions. So basically we can't use 0xfb000000 like
> > > we currently have, let's use 0xf7000000 instead unless
> > > somebody has better ideas.
> > 
> > And now 0xf7000000 is in vmalloc area.. Needs to be looked
> > more.
> 
> On internal TI trees, we do have 0xfa400000 working.
> Guess that is the magic number.

Great and thanks for pointing out that hole in the mapping.

Here's an updated version of this patch using 0xfa400000. Few
other things had to be updated accordingly.

Regards,

Tony
