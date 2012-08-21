From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Aug 2012 09:31:25 +0200
Subject: [PATCH 3/3] ARM: Kirkwood: increase atomic coherent pool size
In-Reply-To: <20120820231419.GB755@harshnoise.musicnaut.iki.fi>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
 <1345459648-24263-4-git-send-email-m.szyprowski@samsung.com>
 <20120820231419.GB755@harshnoise.musicnaut.iki.fi>
Message-ID: <000301cd7f6e$fc925130$f5b6f390$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, August 21, 2012 1:14 AM Aaro Koskinen wrote:

> On Mon, Aug 20, 2012 at 12:47:28PM +0200, Marek Szyprowski wrote:
> > The default 256 KiB coherent pool may be too small for some of the Kirkwood
> > devices, so increase it to make sure that devices will be able to allocate
> > their buffers with GFP_ATOMIC flag.
> [...]
> > +	/*
> > +	 * Some Kirkwood devices allocate their coherent buffers from atomic
> > +	 * context. Increase size of atomic coherent pool to make sure such
> > +	 * the allocations won't fail.
> > +	 */
> > +	init_dma_coherent_pool_size(SZ_1M);
> 
> Not sure if it's a valid use case, but what if some user wants to drop
> e.g. SATA driver and and free up some memory. Would a smaller coherent
> pool kernel parameter override this code in that case?

Kernel command line parameter always overrides the value set by platform code
(or the default 256KiB).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
