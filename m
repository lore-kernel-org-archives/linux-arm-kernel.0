From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 19 Aug 2014 20:27:34 +0530
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140819144423.GE30401@n2100.arm.linux.org.uk>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140814085301.GJ2452@ldesroches-Latitude-E6320>
 <20140814085753.GS30401@n2100.arm.linux.org.uk>
 <20140819134507.GJ13288@intel.com>
 <20140819144423.GE30401@n2100.arm.linux.org.uk>
Message-ID: <20140819145734.GN13288@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 03:44:23PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 19, 2014 at 07:15:07PM +0530, Vinod Koul wrote:
> > On Thu, Aug 14, 2014 at 09:57:53AM +0100, Russell King - ARM Linux wrote:
> > > It's got something to do with the async engine API, and seems to be
> > > something to do with whether a descriptor can have other transactions
> > > added to it, and whether a descriptor can be re-used (async-tx engines
> > > typically allocate a fixed set of descriptors and recycle them.)
> > Yes this is my understanding too. Async API IIUC can reuse descriptors and
> > if engine doesnt support this is a way to tell them please do use that.
> > 
> > For slave dmanegine API we need to ignore it.
> 
> We shouldn't ignore it - ignoring it makes it harder to implement a DMA
> engine driver which supports both the slave and async APIs, because
> we then need to know the reason for the channel being requested.
Do you have such usage coming up near future :)
> 
> Ignoring it until it can be understood and documented is an approach I
> would agree with though.
Certainly, I am asking Dan to add more clarity on these bits to help
improve.

-- 
~Vinod
