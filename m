From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Aug 2013 00:37:30 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130805071106.GA14215@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802090355.GF7656@atomide.com>
 <20130802093222.GA8982@kroah.com>
 <20130802123445.GG7656@atomide.com>
 <20130802141449.GA7533@kroah.com>
 <20130805065535.GP7656@atomide.com>
 <20130805071106.GA14215@kroah.com>
Message-ID: <20130805073730.GU7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH <greg@kroah.com> [130805 00:16]:
> On Sun, Aug 04, 2013 at 11:55:35PM -0700, Tony Lindgren wrote:
> > 
> > But for things that are completely bus specific for various SoCs, how
> > would you like to handle those?
> > 
> > For example, we are currently using platform bus and bus notifiers and
> > then the runtime PM calls from device driver trigger the bus specific
> > things.
> > 
> > Would you prefer to instead use a custom bus instead of extending
> > the platform bus for things like that?
> 
> Yes I would.  I would really like to only use the platform bus for very
> few things, if any at all.

OK. How would you prefer to set up things from driver point of view
so the device drivers don't need to care which bus it's connected to?

That is, for the let's say 10 - 15 slightly different types of busses
that are currently handled as platform bus?

Should we have some generic replacement for struct platform_driver
that can bind to let's say SoC specific bus implementation?

Regards,

Tony
