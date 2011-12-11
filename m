From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 12 Dec 2011 09:45:59 +1100
Subject: [PATCH 6/8] common: dma-mapping: change alloc/free_coherent
 method to more generic alloc/free_attrs
In-Reply-To: <1323448798-18184-7-git-send-email-m.szyprowski@samsung.com>
References: <1323448798-18184-1-git-send-email-m.szyprowski@samsung.com>
 <1323448798-18184-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20111212094559.e4af7c0ab6633de400487fde@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, 09 Dec 2011 17:39:56 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Introduce new alloc/free/mmap methods that take attributes argument.
> alloc/free_coherent can be implemented on top of the new alloc/free
> calls with NULL attributes. dma_alloc_non_coherent can be implemented
> using DMA_ATTR_NONCOHERENT attribute, dma_alloc_writecombine can also
> use separate DMA_ATTR_WRITECOMBINE attribute. This way the drivers will
> get more generic, platform independent way of allocating dma memory
> buffers with specific parameters.
> 
> One more attribute can be usefull: DMA_ATTR_NOKERNELVADDR. Buffers with
> such attribute will not have valid kernel virtual address. They might be
> usefull for drivers that only exports the DMA buffers to userspace (like
> for example V4L2 or ALSA).
> 
> mmap method is introduced to let the drivers create a user space mapping
> for a DMA buffer in generic, architecture independent way.
> 
> TODO: update all dma_map_ops clients for all architectures

To give everyone some chance, you should come up with a transition plan
rather than this "attempt to fix everyone at once" approach.  You could
(for example) just add the new methods now and only remove them in the
following merge window when all the architectures have had a chance to
migrate.

And, in fact, (as I presume you know) this patch just breaks everyone
with no attempt to cope.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111212/bd42b5fd/attachment.sig>
