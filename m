From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 16:06:10 +0100
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
	method to more generic alloc/free_attrs
In-Reply-To: <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
Message-ID: <20110620150610.GG26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 11:45:41PM +0900, KyongHo Cho wrote:
> I still don't agree with your idea that change alloc_coherent() with alloc().
> As I said before, we actually do not need dma_alloc_writecombine() anymore
> because it is not different from dma_alloc_coherent() in ARM.

Wrong - there is a difference.  For pre-ARMv6 CPUs, it returns memory
with different attributes from DMA coherent memory.

And we're not going to sweep away pre-ARMv6 CPUs any time soon.  So
you can't ignore dma_alloc_writecombine() which must remain to sanely
support framebuffers.
