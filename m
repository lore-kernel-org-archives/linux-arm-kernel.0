From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jun 2012 11:01:11 +0200
Subject: [Linaro-mm-sig] [PATCHv2 1/6] common: DMA-mapping: add
 DMA_ATTR_NO_KERNEL_MAPPING attribute
In-Reply-To: <20120613185202.GM4829@phenom.ffwll.local>
References: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
 <1339588218-24398-2-git-send-email-m.szyprowski@samsung.com>
 <20120613185202.GM4829@phenom.ffwll.local>
Message-ID: <003601cd4a0c$431d7780$c9586680$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, June 13, 2012 8:52 PM Daniel Vetter wrote:

> On Wed, Jun 13, 2012 at 01:50:13PM +0200, Marek Szyprowski wrote:
> > This patch adds DMA_ATTR_NO_KERNEL_MAPPING attribute which lets the
> > platform to avoid creating a kernel virtual mapping for the allocated
> > buffer. On some architectures creating such mapping is non-trivial task
> > and consumes very limited resources (like kernel virtual address space
> > or dma consistent address space). Buffers allocated with this attribute
> > can be only passed to user space by calling dma_mmap_attrs().
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Looks like a nice little extension to support dma-buf for the common case,
> so:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> One question is whether we should go right ahead and add kmap support for
> this, too (with a default implementation that simply returns a pointer to
> the coherent&contigous dma mem), but I guess that can wait until a
> use-case pops up.

I will wait with this until there will be real use cases. Let's get the
patch into mainline first.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
