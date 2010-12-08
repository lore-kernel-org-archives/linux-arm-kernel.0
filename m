From: vbarshak@mvista.com (Valentine Barshak)
Date: Wed, 08 Dec 2010 13:25:14 +0300
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range and v6_dma_flush_range
	RWFO fix
In-Reply-To: <20101124183936.GA18796@mvista.com>
References: <20101124183936.GA18796@mvista.com>
Message-ID: <4CFF5D0A.7030700@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Valentine Barshak wrote:
> Updated according to the comments to avoid r/w outside the buffer and
> used byte r/w for the possible unaligned data. Seems to work fine.
>
>   
Any comments on this one?

Thanks,
Val.
> Cache ownership must be acqired by reading/writing data from the
> cache line to make cache operation have the desired effect on the
> SMP MPCore CPU. However, the ownership is never aquired in the
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
