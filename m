From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 28 Nov 2013 13:25:28 -0800
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131128193917.GC4634@e103592.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131127230650.GA6162@kroah.com>
 <20131128102845.GB21354@mudshark.cambridge.arm.com>
 <20131128173339.GB4634@e103592.cambridge.arm.com>
 <20131128191331.GB2385@kroah.com>
 <20131128193917.GC4634@e103592.cambridge.arm.com>
Message-ID: <20131128212528.GA6144@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 07:39:17PM +0000, Dave Martin wrote:
> On Thu, Nov 28, 2013 at 11:13:31AM -0800, Greg KH wrote:
> > On Thu, Nov 28, 2013 at 05:33:39PM +0000, Dave Martin wrote:
> > > On Thu, Nov 28, 2013 at 10:28:45AM +0000, Will Deacon wrote:
> > > > Hi Greg,
> > > > 
> > > > On Wed, Nov 27, 2013 at 11:06:50PM +0000, Greg KH wrote:
> > > > > On Wed, Nov 27, 2013 at 05:28:06PM +0000, Dave Martin wrote:
> > > > > > >From will.deacon at arm.com Wed Nov 20 12:06:22 2013
> > > > > > A number of discussion points remain to be resolved:
> > > > > > 
> > > > > >   - Use of the ranges property and describing slave vs master bus
> > > > > >     address ranges. In the latter case, we actually want to describe our
> > > > > >     address space with respect to the bus on which the bus masters,
> > > > > >     rather than the parent. This could potentially be achieved by adding
> > > > > >     properties such as dma-parent and dma-ranges (already used by PPC?)
> > > > > > 
> > > > > >   - Describing masters that master through multiple different buses
> > > > > > 
> > > > > >   - How on Earth this fits in with the Linux device model (it doesn't)
> > > > > 
> > > > > How does this _not_ fit into the Linux device model?  What am I missing
> > > > > here that precludes the use of the "driver/device/bus" model we have
> > > > > today?
> > > 
> > > The physical-sockets history of buses like PCI tends to force a simple
> > > tree-like topology as a natural consequence.  You also end up with
> > > closely linked topologies for power, clocks, interrupts etc., because
> > > those all pass through the same sockets, so it's difficult to have a
> > > different structure.
> > 
> > There's nothing in the driver core that enforces such a topology.
> 
> Maybe not ... I have to wrap my head around that stuff a bit more.
> 
> > > On SoC, those constraints have never existed and are not followed.  A
> > > device's interface to the system is almost always split into multiple
> > > connections, not covered by a single design or standard.  The problem
> > > now is that increasing complexity means that the sometimes bizarre
> > > topology features of SoCs are becoming less and less transparent for
> > > software.
> > > 
> > > The device model currently seems to assume that certain things (power,
> > > DMA and MMIO accessibility) follow the tree (which may not work for many
> > > SoCs), and some other things (clocks, regulators, interrupts etc.) are
> > > not incorporated at all -- making them independent, but it may make some
> > > abstractions impossible today.
> > > 
> > > How much this matters for actual systems is hard to foresee yet.  Since
> > > not _all_ possible insanities find their way into silicon.  The
> > > onus should certainly be on us (i.e., the ARM/SoC community) to
> > > demonstrate if the device model needs to change, and to find practical
> > > ways to change it that minimise the resulting churn.
> > 
> > Yes it is, you all are the ones tasked with implementing the crazy crap
> > the hardware people have created, best of luck with that :)
> 
> Agreed.  The first assumption should be that we can fit in with the
> existing device model -- we should only reconsider if we find that
> to be impossible.

Let me know if you think it is somehow impossible, but you all should
really push back on the insane hardware designers that are forcing you
all to do this work.  I find it "interesting" how this all becomes your
workload for their crazy ideas.

Best of luck,

greg k-h
