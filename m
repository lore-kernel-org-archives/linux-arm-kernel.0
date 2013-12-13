From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Dec 2013 13:37:17 +0000
Subject: [PATCH 3/3] swiotlb: Add support for CMA allocations
In-Reply-To: <52AA595B.7090708@codeaurora.org>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
 <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
 <1da8f502-0e34-4b54-929e-bcbe40b20b7f@email.android.com>
 <52A66211.6010707@codeaurora.org>
 <83dd58eb-9a44-4b76-aa68-4669b26acab8@email.android.com>
 <20131210102555.GB2338@mudshark.cambridge.arm.com>
 <20131210104231.GB2521@darko.cambridge.arm.com>
 <52AA595B.7090708@codeaurora.org>
Message-ID: <20131213133717.GD22933@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:48:27AM +0000, Laura Abbott wrote:
> On 12/10/2013 2:42 AM, Catalin Marinas wrote:
> > For coherency, we could build it on top of whatever dma (allocation) ops
> > are registered, whether swiotlb or iommu (see part of
> > https://git.kernel.org/cgit/linux/kernel/git/cmarinas/linux-aarch64.git/commit/?h=devel&id=c67fe405be6b55399c9e53dfeba5e2c6b930e429)
> >
> > Regarding iommu, I don't think we need CMA on top, so it makes sense to
> > keep the CMA in the swiotlb code.
> 
> Catalin, is that just sample/design code or is that patch going to be 
> merged sometime?

I was originally hoping that on ARMv8 systems the DMA will be coherent.
But I got requests (though people claiming that only for development)
for cache coherency, hence the above patch. I would like to merge it at
some point (this form or another). The pending issue is describing
whether a device or bus is coherent or not. So there is some work on
system topology and DT before.

-- 
Catalin
