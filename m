From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 14 Mar 2013 22:37:41 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130314212921.GB18505@obsidianresearch.com>
References: <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
 <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
 <20130314172555.GA14048@obsidianresearch.com>
 <20130314210926.GA9098@avionic-0098.mockup.avionic-design.de>
 <20130314212921.GB18505@obsidianresearch.com>
Message-ID: <20130314213741.GA17186@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 03:29:21PM -0600, Jason Gunthorpe wrote:
> On Thu, Mar 14, 2013 at 10:09:26PM +0100, Thierry Reding wrote:
> 
> > > ranges = <0x82000000 0 0x80000000  0x80000000  0 0x00001000   /* port 0 registers */
> > > 	  0x82000000 0 0x80001000  0x80001000  0 0x00001000   /* port 1 registers */
> > > 	  0x81000000 0          0  0x82000000  0 0x00010000   /* downstream I/O */
> > > 	  0x82000000 0 0xa0000000  0xa0000000  0 0x10000000   /* non-prefetchable memory */
> > > 	  0xc2000000 0 0xb0000000  0xb0000000  0 0x10000000>; /* prefetchable memory */
> > > 
> > > Which says 'access to CPU address 0xa0000000 produces a PCI-E memory TLP with
> > > address 0xa0000000' - this is the 'normal' case, I assume that is what
> > > happens on tegra?
> > > 
> > > It also says 'access to CPU address 0x82000000 produces a PCI-E IO TLP
> > > with address 0' - this translation is something Linux typically
> > > expects..
> > 
> > Both of the above paragraphs are true. However accesses to the windows
> > at 0x80000000 and 0x80001000 don't generate memory TLPs but type 0
> > configuration space TLPs.
> 
> By my understanding access to 0x80000000/0x80001000 doesn't generate
> any externally visible TLPs?

Now that you mention it, that's probably correct, yes.

> IHMO modeling this register space as a controller-internal MMIO region
> associated with the bridge is reasonable... After all, you are
> iomapping it and accessing it with readl/writel - those are MMIO
> functions..

Yes, I think that'd be okay.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/6ed5fe50/attachment-0001.sig>
