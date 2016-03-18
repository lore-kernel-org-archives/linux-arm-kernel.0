From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2016 10:58:33 +0000
Subject: [PATCH v2] ARM: DMA: Fix kzalloc flags in __dma_alloc
In-Reply-To: <1458293329-5519-1-git-send-email-acourbot@nvidia.com>
References: <1458293329-5519-1-git-send-email-acourbot@nvidia.com>
Message-ID: <20160318105833.GF19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 06:28:49PM +0900, Alexandre Courbot wrote:
> Commit 19e6e5e5392b ("ARM: 8547/1: dma-mapping: store buffer
> information") allocates a structure meant for internal buffer management
> with the GFP flags of the buffer itself. This can trigger the following
> safeguard in the slab/slub allocator:
> 
> 	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
> 		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
> 		BUG();
> 	}
> 
> Fix this by filtering the flags that make the slab allocator unhappy.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Rabin Vincent <rabin@rab.in>

Looks much better than the original.  Please send it to the patch system,
thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
