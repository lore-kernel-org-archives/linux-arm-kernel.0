From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Dec 2010 09:30:54 +0000
Subject: [PATCH 2/4] Optionally flush entire dcache from v6_dma_flush_range
In-Reply-To: <1292302659-1863-3-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-3-git-send-email-john.stultz@linaro.org>
Message-ID: <20101214093054.GB18425@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 08:57:37PM -0800, John Stultz wrote:
> From: Arve Hj?nnev?g <arve@android.com>
> 
> If CACHE_FLUSH_RANGE_LIMIT is defined, then the entire dcache will
> be flushed if the requested range is larger than this limit.

This has been talked about before, and it's not the correct place to do
this.  With a scatterlist, you'll end up repeatedly flushing the cache.
