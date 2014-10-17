From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 17 Oct 2014 13:02:26 +0530
Subject: [PATCH v6 1/3] dma: at_xdmac: creation of the atmel eXtended
 DMA Controller driver
In-Reply-To: <20141017065357.GE2367@ldesroches-Latitude-E6320>
References: <1412175565-810-1-git-send-email-ludovic.desroches@atmel.com>
 <1412175565-810-2-git-send-email-ludovic.desroches@atmel.com>
 <20141015133004.GP1638@intel.com>
 <20141016141048.GC2367@ldesroches-Latitude-E6320>
 <20141016161233.GJ1638@intel.com>
 <20141017065357.GE2367@ldesroches-Latitude-E6320>
Message-ID: <20141017073226.GM1638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 08:53:57AM +0200, Ludovic Desroches wrote:

> > 
> > > > For memcpy why should we need slave_config. The system memory source and
> > > > destination width could be assumed to relastic values and then burst sizes
> > > > maxed for performance. These values make more sense for periphral where we
> > > > have to match up with the periphral
> > > 
> > > I don't tell I need slave_config. We have already talked about this. I don't
> > > see the problem. It is only a comment, a reminder. The only information
> > > I may need, one day, is the direction because we have to set src and dst
> > > interfaces. At the moment, all our products are done in a way nand flash
> > > and DDR are on the same interface so we don't have to care about
> > > direction.
> > > Since we don't have the direction, two solutions:
> > > - remember this limitation for next products, that's why there is this reminder,
> > > - change our nand driver in order to see nand as a peripheral instead of
> > >   a memory. 
> > I think treating NAND as memory may not be a right model. It should be
> > treated as periphral with incrementing and decrementing address value. That
> > way you should be able to set the right properties for it.
> > 
> > The system memory copy is right model for memcpy.
> 
> Ok, I'll discuss of it with the atmel nand maintener. Even if there is
> something to improve here, I hope it is not considered as a blocking point
> to get the xdmac driver included into 3.19 because at the moment we have no
> DMA on the SAMA5D4 recently introduced.

That sounds good to me, no this is non blocker here

And yes keeping the comment here is fine to warn folks.

-- 
~Vinod
