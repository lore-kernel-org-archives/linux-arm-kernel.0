From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Aug 2013 09:51:23 +0100
Subject: [PATCH RFC 51/51] ARM: 7805/1: mm: change max*pfn to include
 the physical offset of memory
In-Reply-To: <CAL_Jsq+9+LBVCwQKKJznbPP06WA0Wn-7m+cFoyF==GRkP9XXmQ@mail.gmail.com>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
 <E1V51J5-0006uq-1h@rmk-PC.arm.linux.org.uk>
 <CAL_Jsq+9+LBVCwQKKJznbPP06WA0Wn-7m+cFoyF==GRkP9XXmQ@mail.gmail.com>
Message-ID: <20130806085123.GC23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 10:15:11PM -0500, Rob Herring wrote:
> On Thu, Aug 1, 2013 at 5:25 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > +/* The ARM override for dma_max_pfn() */
> > +static inline unsigned long dma_max_pfn(struct device *dev)
> > +{
> > +       return PHYS_PFN_OFFSET + dma_to_pfn(dev, *dev->dma_mask);
> 
> Do we need to handle dev == NULL case?

No, look at where it's used and the code it's replacing.  You'll find
that its callsites handle the dev = NULL case.
