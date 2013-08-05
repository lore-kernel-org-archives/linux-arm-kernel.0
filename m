From: greg@kroah.com (Greg KH)
Date: Mon, 5 Aug 2013 16:02:54 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130805073730.GU7656@atomide.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802090355.GF7656@atomide.com>
 <20130802093222.GA8982@kroah.com>
 <20130802123445.GG7656@atomide.com>
 <20130802141449.GA7533@kroah.com>
 <20130805065535.GP7656@atomide.com>
 <20130805071106.GA14215@kroah.com>
 <20130805073730.GU7656@atomide.com>
Message-ID: <20130805080254.GA15376@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 12:37:30AM -0700, Tony Lindgren wrote:
> * Greg KH <greg@kroah.com> [130805 00:16]:
> > On Sun, Aug 04, 2013 at 11:55:35PM -0700, Tony Lindgren wrote:
> > > 
> > > But for things that are completely bus specific for various SoCs, how
> > > would you like to handle those?
> > > 
> > > For example, we are currently using platform bus and bus notifiers and
> > > then the runtime PM calls from device driver trigger the bus specific
> > > things.
> > > 
> > > Would you prefer to instead use a custom bus instead of extending
> > > the platform bus for things like that?
> > 
> > Yes I would.  I would really like to only use the platform bus for very
> > few things, if any at all.
> 
> OK. How would you prefer to set up things from driver point of view
> so the device drivers don't need to care which bus it's connected to?

What do you mean by "don't need to care"?  How are these drivers talking
to the device on the bus in the first place?  If these are different
busses, then they are talked to in different ways, right?

Any specific examples you have to point to in the kernel today?

> That is, for the let's say 10 - 15 slightly different types of busses
> that are currently handled as platform bus?

What makes them "different"?

> Should we have some generic replacement for struct platform_driver
> that can bind to let's say SoC specific bus implementation?

Hm, like perhaps, "struct driver"?  :)

But again, do you have a specific example I can look at to get an idea
of what you are talking about?

thanks,

greg k-h
