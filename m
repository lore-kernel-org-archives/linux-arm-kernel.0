From: rabin@rab.in (Rabin Vincent)
Date: Fri, 18 Mar 2016 11:38:29 +0100
Subject: [PATCH v2] ARM: DMA: Fix kzalloc flags in __dma_alloc
In-Reply-To: <1458293329-5519-1-git-send-email-acourbot@nvidia.com>
References: <1458293329-5519-1-git-send-email-acourbot@nvidia.com>
Message-ID: <20160318103829.GA15201@lnxrabinv.se.axis.com>
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
> ---
> Changes since v1:
> - Filter flags that may cause problem instead of forcing GFP_KERNEL
>   (and risk sleeping in atomic context), as suggested by Rabin.

Acked-by: Rabin Vincent <rabin@rab.in>

Thanks.
