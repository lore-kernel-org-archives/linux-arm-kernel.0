From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 15 Jan 2013 16:56:02 -0500
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <20130115201617.GC25500@titan.lakedaemon.net>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <1353421905-3112-1-git-send-email-m.szyprowski@samsung.com>
 <50F3F289.3090402@web.de>
 <20130115165642.GA25500@titan.lakedaemon.net>
 <20130115175020.GA3764@kroah.com>
 <20130115201617.GC25500@titan.lakedaemon.net>
Message-ID: <20130115215602.GF25500@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Soeren,

On Tue, Jan 15, 2013 at 03:16:17PM -0500, Jason Cooper wrote:
> If my understanding is correct, one of the drivers (most likely one)
> either asks for too small of a dma buffer, or is not properly
> deallocating blocks from the per-device pool.  Either case leads to
> exhaustion, and falling back to the atomic pool.  Which subsequently
> gets wiped out as well.

If my hunch is right, could you please try each of the three dvb drivers
in turn and see which one (or more than one) causes the error?

thx,

Jason.
