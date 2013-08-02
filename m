From: greg@kroah.com (Greg KH)
Date: Fri, 2 Aug 2013 22:16:59 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802123752.GH7656@atomide.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802115334.GN2465@mudshark.cambridge.arm.com>
 <20130802123752.GH7656@atomide.com>
Message-ID: <20130802141659.GB7533@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 05:37:52AM -0700, Tony Lindgren wrote:
> * Will Deacon <will.deacon@arm.com> [130802 05:00]:
> > On Thu, Aug 01, 2013 at 08:27:30PM +0100, Greg KH wrote:
> > > 
> > > The driver core handles this really well, you just have to create new
> > > busses, and don't rely on the "catch-all" platform_bus.
> > 
> > Agreed, it's time that we started to describe these non-probable buses as
> > separate bus_types, with controller logic for configuring the bus itself
> > (there are weird-and-wonderful ring-based designs on the horizon which can
> > require a fair amount of setup).
> 
> Yes we somehow need hardware specific buses, but they should appear
> generic to the device drivers without having to modify each device
> driver using these buses for each bus.

I just wrote how to do that, and there are lots of examples of it in the
kernel already from simple, "if this chip then write this way" to
complex, "here's a packet, send it to the hardware" levels.  It all
depends on how much work you want to do.

greg k-h
