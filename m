From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 19 Aug 2014 19:15:07 +0530
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140814085753.GS30401@n2100.arm.linux.org.uk>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140814085301.GJ2452@ldesroches-Latitude-E6320>
 <20140814085753.GS30401@n2100.arm.linux.org.uk>
Message-ID: <20140819134507.GJ13288@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 09:57:53AM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 14, 2014 at 10:53:01AM +0200, Ludovic Desroches wrote:
> > On Wed, Jul 30, 2014 at 06:03:13PM +0200, Maxime Ripard wrote:
> > > The dmaengine is neither trivial nor properly documented at the moment, which
> > > means a lot of trial and error development, which is not that good for such a
> > > central piece of the system.
> > > 
> > > Attempt at making such a documentation.
> > 
> > Good idea, many questions are asked when writing a new dmaengine driver.
> > 
> > For instance I didn't find how to use the DMA_CTRL_ACK flags.
> > 
> > - How this flag has to be managed? For instance, async_tx_ack is used in
> > dmaengine driver but also in some devices.
> > - Is it mandatory to deal with this flag? It seems some dmaengine
> > drivers don't care about it.
> This is one part of the DMA engine API that even I don't understand.
> 
> It's got something to do with the async engine API, and seems to be
> something to do with whether a descriptor can have other transactions
> added to it, and whether a descriptor can be re-used (async-tx engines
> typically allocate a fixed set of descriptors and recycle them.)
Yes this is my understanding too. Async API IIUC can reuse descriptors and
if engine doesnt support this is a way to tell them please do use that.

For slave dmanegine API we need to ignore it.
> 
> I was never able to get to the bottom of what that flag meant or how
> it should be used with the DMA slave API (and I suspect everyone else
> just gave up trying to understand it as well.)

-- 
~Vinod
