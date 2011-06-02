From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jun 2011 10:52:24 +0100
Subject: [PATCH 1/5] net: ep93xx_eth: pass struct device to DMA API
	functions
In-Reply-To: <89df467f9811b4f869513de3ada90ce7de74c6d1.1307006502.git.mika.westerberg@iki.fi>
References: <89df467f9811b4f869513de3ada90ce7de74c6d1.1307006502.git.mika.westerberg@iki.fi>
Message-ID: <20110602095224.GT3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 12:38:13PM +0300, Mika Westerberg wrote:
> We shouldn't use NULL for any DMA API functions, unless we are dealing with
> ISA or EISA device. So pass correct struct dev pointer to these functions.

Thanks for doing this - it certainly makes things more correct, even
if the original problem has been resolved by the troublesome GFP_DMA
commit having been reverted.  As such I think this patch series should
still be applied.

I think the series should be re-ordered so that patch 5 is first however,
as you can do that with or without the remainder of the patches.

For the entire series:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
