From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 21:06:19 +0000
Subject: [PATCH 2/2] dma: change coherent memory to normal noncached
In-Reply-To: <1258748951-10548-2-git-send-email-adharmap@codeaurora.org>
References: <1258748951-10548-1-git-send-email-adharmap@codeaurora.org>
	<1258748951-10548-2-git-send-email-adharmap@codeaurora.org>
Message-ID: <20091120210619.GI16920@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 12:29:11PM -0800, Abhijeet Dharmapurikar wrote:
> We need dma_alloc_coherent() to use its own page protection modifier,
> which causes it to behave the same as dma_alloc_writecombine() on ARMv7,
> and with the existing behaviour (for the time being) on ARMv6 and below.
> We should leave pgprot_noncached() well alone until we know that its
> other places need to be changed.

As I say, I have a large set of changes which impacts this patch, and
the original patch is already in my DMA patch queue.
