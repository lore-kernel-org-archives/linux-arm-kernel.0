From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Dec 2010 09:54:29 +0000
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range and v6_dma_flush_range
	RWFO fix (take 2)
In-Reply-To: <20101210182442.GA8293@mvista.com>
References: <20101210182442.GA8293@mvista.com>
Message-ID: <1292234069.21787.0.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-12-10 at 18:24 +0000, Valentine Barshak wrote:
> Cleaned up v6_dma_inv_range change a bit, preseving the order of
> start/end address processing.
> 
> Cache ownership must be acquired by reading/writing data from the
> cache line to make cache operation have the desired effect on the
> SMP MPCore CPU. However, the ownership is never acquired in the
> v6_dma_inv_range function when cleaning the first line and
> flushing the last one, in case the address is not aligned
> to D_CACHE_LINE_SIZE boundary.
> Fix this by reading/writing data if needed, before performing
> cache operations.
> While at it, fix v6_dma_flush_range to prevent RWFO outside
> the buffer.
> 
> Signed-off-by: Valentine Barshak <vbarshak@mvista.com>
> Signed-off-by: George G. Davis <gdavis@mvista.com>
> Cc: stable at kernel.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
