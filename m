From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 02:03:55 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801192730.GC9174@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
Message-ID: <20130802090355.GF7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH <greg@kroah.com> [130801 12:33]:
> On Thu, Aug 01, 2013 at 07:35:31PM +0100, Will Deacon wrote:
> > Hello,
> > 
> > Whilst Linux implements a bunch of different bus types (many of which
> > are in fact virtual), devices sitting on non-probable, memory mapped
> > buses inside SoCs typically live on either the platform_bus or the
> > amba_bus. So far, this has worked out alright; the buses haven't needed
> > to be visible to software and no additional software control is really
> > required from the OS. However, as I/O coherency and hardware
> > virtualisation capabilities start to creep into ARM-based SoCs, Linux
> > needs to know the topology of the system on which it is running.
> > 
> > Naturally, this would need to be described as a device-tree binding and
> > communicate:
> > 
> >   - Buses which can be configured as coherent, including which devices
> >     on those buses can be made coherent.
> > 
> >   - How IOMMUs sit on the bus and interact with masters on that bus (the
> >     current one-IOMMU-driver-per-bus may not work well for the
> >     platform_bus).
> 
> I've been waiting for people to finally run into this one, and realize
> that they shouldn't be using "platform_bus" :)
> 
> >   - QoS and PM constraints. This isn't really in my area, but we do have
> >     buses that have these features and expect software to control them.
> > 
> >   - The system topology and linkages between buses and devices.
> 
> The driver core handles this really well, you just have to create new
> busses, and don't rely on the "catch-all" platform_bus.

Hmm do you have some example of a device driver that is generic and
is supported on platform_bus and some other bus?

For example, we have a need for a custom bus to do bus specific reset
and idling of devices for example but all the device drivers are
dt/platform devices.

Regards,

Tony
