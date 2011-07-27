From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 27 Jul 2011 14:36:47 +0530
Subject: [PATCH] Improve slave/cyclic DMA engine documentation (was:
	[PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability)
In-Reply-To: <20110727090107.GC21584@n2100.arm.linux.org.uk>
References: <20110725092749.GB9653@n2100.arm.linux.org.uk>
	<002001cc4ab6$0d7cd590$287680b0$%kim@samsung.com>
	<20110725103629.GF9653@n2100.arm.linux.org.uk>
	<1311590884.29703.2.camel@vkoul-mobl4>
	<20110725105754.GG9653@n2100.arm.linux.org.uk>
	<1311591717.29703.7.camel@vkoul-mobl4>
	<20110725113926.GH9653@n2100.arm.linux.org.uk>
	<1311595303.29703.31.camel@vkoul-mobl4>
	<20110726075720.GL9653@n2100.arm.linux.org.uk>
	<1311672933.24316.1.camel@vkoul-mobl4>
	<20110727090107.GC21584@n2100.arm.linux.org.uk>
Message-ID: <1311757607.1536.107.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-07-27 at 10:01 +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 26, 2011 at 03:05:33PM +0530, Vinod Koul wrote:
> > On Tue, 2011-07-26 at 08:57 +0100, Russell King - ARM Linux wrote:
> > > Here's an updated patch.
> > > 
> > > 8<----------
> > > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > > DMAEngine: Improve slave/cyclic documentation
> > > 
> > > Improve the documentation for the slave and cyclic DMA engine support
> > > reformatting it for easier reading, adding further APIs, splitting it
> > > into five steps, and including references to the documentation in
> > > dmaengine.h.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > ---
> > >  Documentation/dmaengine.txt |  211 ++++++++++++++++++++++++++++++-------------
> > >  1 files changed, 146 insertions(+), 65 deletions(-)
> > > 
> > > diff --git a/Documentation/dmaengine.txt b/Documentation/dmaengine.txt
> > > index 5a0cb1e..8c2e888 100644
> > > --- a/Documentation/dmaengine.txt
> > > +++ b/Documentation/dmaengine.txt
> > > @@ -10,87 +10,168 @@
> > >  Below is a guide to device driver writers on how to use the Slave-DMA API of the
> > >  DMA Engine. This is applicable only for slave DMA usage only.
> > >  
> > > -The slave DMA usage consists of following steps
> > > +The slave DMA usage consists of following steps:
> > >  1. Allocate a DMA slave channel
> > >  2. Set slave and controller specific parameters
> > >  3. Get a descriptor for transaction
> > >  4. Submit the transaction and wait for callback notification
> > > +5. Issue pending requests
> > Thanks Russell,
> > 
> > Applied with change to 4 above. Moved "and wait for callback
> > notification" to 5.
> 
> BTW, did you apply this one or the later one with the improved
> documentation for dma mapping and fixed interface for slave
> transfers etc. ?
I changed it to second one, not pushed yet.
I am rebasing the tree to 3.0. You should see updated version in tree
later in the evening today

-- 
~Vinod
