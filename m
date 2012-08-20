From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 21 Aug 2012 02:14:19 +0300
Subject: [PATCH 3/3] ARM: Kirkwood: increase atomic coherent pool size
In-Reply-To: <1345459648-24263-4-git-send-email-m.szyprowski@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
 <1345459648-24263-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120820231419.GB755@harshnoise.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 12:47:28PM +0200, Marek Szyprowski wrote:
> The default 256 KiB coherent pool may be too small for some of the Kirkwood
> devices, so increase it to make sure that devices will be able to allocate
> their buffers with GFP_ATOMIC flag.
[...]
> +	/*
> +	 * Some Kirkwood devices allocate their coherent buffers from atomic
> +	 * context. Increase size of atomic coherent pool to make sure such
> +	 * the allocations won't fail.
> +	 */
> +	init_dma_coherent_pool_size(SZ_1M);

Not sure if it's a valid use case, but what if some user wants to drop
e.g. SATA driver and and free up some memory. Would a smaller coherent
pool kernel parameter override this code in that case?

A.
