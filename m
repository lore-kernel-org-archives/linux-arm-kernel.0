From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Mar 2016 12:34:08 +0000
Subject: [Query] doubt on parameters passed to dma_map_single_attrs() API
In-Reply-To: <eedb87e1131d74a77b49599648cc5aac@codeaurora.org>
References: <eedb87e1131d74a77b49599648cc5aac@codeaurora.org>
Message-ID: <20160322123408.GN19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 03:53:02PM +0530, Sodagudi Prasad wrote:
> 
> Hi All,
> 
> Would like to check whether the dma_map_single_attrs() API, can accept ptr
> variable from high memory or not?

It can't.  Direct mapped, lowmem only.

No pointers allowed from dma_alloc_coherent(), dma_alloc_writecombine(),
ioremap(), vmalloc(), kmap(), kmap_atomic() or similar function, or
derived from one of these.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
