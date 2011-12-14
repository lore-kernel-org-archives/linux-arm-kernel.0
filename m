From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 14 Dec 2011 13:37:07 +0100
Subject: [PATCH 6/8] common: dma-mapping: change alloc/free_coherent method
 to more generic alloc/free_attrs
In-Reply-To: <20111212094559.e4af7c0ab6633de400487fde@canb.auug.org.au>
References: <1323448798-18184-1-git-send-email-m.szyprowski@samsung.com>
 <1323448798-18184-7-git-send-email-m.szyprowski@samsung.com>
 <20111212094559.e4af7c0ab6633de400487fde@canb.auug.org.au>
Message-ID: <040501ccba5d$1821e0a0$4865a1e0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sunday, December 11, 2011 11:46 PM Stephen Rothwell wrote:

> On Fri, 09 Dec 2011 17:39:56 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > Introduce new alloc/free/mmap methods that take attributes argument.
> > alloc/free_coherent can be implemented on top of the new alloc/free
> > calls with NULL attributes. dma_alloc_non_coherent can be implemented
> > using DMA_ATTR_NONCOHERENT attribute, dma_alloc_writecombine can also
> > use separate DMA_ATTR_WRITECOMBINE attribute. This way the drivers will
> > get more generic, platform independent way of allocating dma memory
> > buffers with specific parameters.
> >
> > One more attribute can be usefull: DMA_ATTR_NOKERNELVADDR. Buffers with
> > such attribute will not have valid kernel virtual address. They might be
> > usefull for drivers that only exports the DMA buffers to userspace (like
> > for example V4L2 or ALSA).
> >
> > mmap method is introduced to let the drivers create a user space mapping
> > for a DMA buffer in generic, architecture independent way.
> >
> > TODO: update all dma_map_ops clients for all architectures
> 
> To give everyone some chance, you should come up with a transition plan
> rather than this "attempt to fix everyone at once" approach.  You could
> (for example) just add the new methods now and only remove them in the
> following merge window when all the architectures have had a chance to
> migrate.
> 
> And, in fact, (as I presume you know) this patch just breaks everyone
> with no attempt to cope.

Yes, I know that. Next version will include correct fix for this issue as
well as adjustments for other architectures. I was asked to post a current
version of DMA-mapping & IOMMU integration patch rebased on the latest kernel
and I wanted to this before going for holidays to let others to work with the
latest version.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
