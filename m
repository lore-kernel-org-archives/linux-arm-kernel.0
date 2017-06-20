From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 20 Jun 2017 11:19:02 +0200
Subject: clean up and modularize arch dma_mapping interface
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Message-ID: <20170620091902.2dldmf43vhazq6yh@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:25:25PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> for a while we have a generic implementation of the dma mapping routines
> that call into per-arch or per-device operations.  But right now there
> still are various bits in the interfaces where don't clearly operate
> on these ops.  This series tries to clean up a lot of those (but not all
> yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
> way of signaling failures of the mapping routines from the
> implementations to the generic code (and cleans up various drivers that
> were incorrectly using it), and gets rid of the ->set_dma_mask routine
> in favor of relying on the ->dma_capable method that can be used in
> the same way, but which requires less code duplication.
> 
> Btw, we don't seem to have a tree every-growing amount of common dma
> mapping code, and given that I have a fair amount of all over the tree
> work in that area in my plate I'd like to start one.  Any good reason
> to that?  Anyone willing to volunteer as co maintainer?
> 
> The whole series is also available in git:
> 
>     git://git.infradead.org/users/hch/misc.git dma-map

Ack for the 2 drm patches, but I can also pick them up through drm-misc if
you prefer that (but then it'll be 4.14).
-Daniel

> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
