From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 10:08:18 +0900
Subject: [PATCH/RFC 0/2] ARM: shmobile: DT irqpin for r8a7779 and
 marzen-reference
In-Reply-To: <20130405021339.GZ29203@verge.net.au>
References: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
 <20130404035426.GC28297@verge.net.au>
 <Pine.LNX.4.64.1304042325140.21548@axis700.grange>
 <20130405014429.GV29203@verge.net.au>
 <20130405021339.GZ29203@verge.net.au>
Message-ID: <20130410010818.GA11105@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 11:13:39AM +0900, Simon Horman wrote:
> On Fri, Apr 05, 2013 at 10:44:29AM +0900, Simon Horman wrote:
> > On Thu, Apr 04, 2013 at 11:47:05PM +0200, Guennadi Liakhovetski wrote:
> > > Hi Simon
> > > 
> > > On Thu, 4 Apr 2013, Simon Horman wrote:
> > > 
> > > > On Wed, Apr 03, 2013 at 11:18:57AM +0200, Guennadi Liakhovetski wrote:
> > > > > Hi
> > > > > 
> > > > > This 2 patches add DT irqpin support on marzen-reference. Only 
> > > > > compile-tested due to the lack of hardware. The patches can go 
> > > > > independently via their respective trees. irqpin on marzen will not work 
> > > > > if patch 2 is applied before patch 1, but as long as there are no devices, 
> > > > > using irqpin interrupts, no breakage will be caused.
> > > > 
> > > > I have applied both patches and the dependency I mention below.
> > > > I have also applied the small patch, inlined below, to hook-up
> > > > the LAN controller. Unfortunately it doesn't seem to be receiving
> > > > any interrupts. Perhaps I am missing something?
> > > 
> > > Are you sure 28 is the correct number in the irqpin IRQ space? Seems 
> > > strange to me. Should be 1 perhaps (counting from 0), or 2 - not sure how 
> > > that mapping would look like.
> > 
> > Thanks!
> > 
> > 0 seems to be the lucky number, I have SMSC (and NFS root) working
> > on marzen-reference.
> 
> s/0/1/

After all that it seems that I miss-tested the code somehow.

It turns out that 2 is the lucky number.

> > I have posted "ARM: shmobile: marzen-reference: use irqpin for lan"
> > 
> > > > > Guennadi Liakhovetski (2):
> > > > >       irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
> > > > 
> > > > The above patch depends on "[1/3] ARM: shmobile: irqpin: fix handling of
> > > > spurious interrupts in DT case", right?
> > > 
> > > Not functionally. Spurious interrupts occur on sh73a0, the sense bitfield 
> > > is needed for r8a7779. But the latter won't apply without the former, 
> > > that's right.
> > 
> > Thanks, could you reposts this series rebase so that it doesn't require
> > ""[1/3] ARM: shmobile: irqpin: fix handling of spurious interrupts in DT case"
> > to apply cleanly.
> > 
> > Feel free to break the creation of
> > Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> > into a separate patch.
> > 
> > Please add "ARM: shmobile: marzen-reference: use irqpin for lan" to
> > the end of the series with an Ack if you have no objections to it.
> > 
> > > > Has there been any progress in your
> > > > discussions with Magnus about what to do about that patch?
> > > 
> > > No, not yet.
> > 
> > Thanks, understood.
> > 
> > And thanks doubly for this series.
> > It is very nice to have bouth irqpin and ethernet working on
> > marzen-reference.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
