From: w@1wt.eu (Willy Tarreau)
Date: Thu, 21 Nov 2013 23:13:10 +0100
Subject: ARM network performance and dma_mask
In-Reply-To: <528E82C6.2010106@gmail.com>
References: <20131119174323.GH913@1wt.eu>
 <1384885910.8604.110.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119184121.GN913@1wt.eu> <874n780wzc.fsf@natisbad.org>
 <20131120191145.GP8581@1wt.eu> <87txf692zx.fsf@natisbad.org>
 <20131120215435.GT8581@1wt.eu> <20131121004430.GX8581@1wt.eu>
 <20131121183834.GB18513@1wt.eu> <528E82C6.2010106@gmail.com>
Message-ID: <20131121221310.GG18513@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 04:01:42PM -0600, Rob Herring wrote:
> The patch was to fix this issue[1]. It is fixed in the core code because
> dma_mask not being set has been a known issue with DT probing for some
> time. Since most drivers don't seem to care, we've gotten away with it.
> I thought the normal failure mode was drivers failing to probe.

It seems that very few drivers try to set their mask, so probably that
the default value was already OK even though less performant.

> As to why it helps performance, I'm not really sure. Perhaps it is
> causing some bounce buffers to be used.

That's also the thing I have been thinking about, and given this device
only has a 16-bit DDR bus, bounce buffers can make a difference.

> Rob
> 
> [1] http://lists.xen.org/archives/html/xen-devel/2013-10/msg00092.html

Thanks for your quick explanation Rob!
Willy
