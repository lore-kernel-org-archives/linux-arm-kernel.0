From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 28 Apr 2017 18:14:11 +0200
Subject: [PATCH] drivers: dma-mapping: Do not leave an invalid
 area->pages pointer in dma_common_contiguous_remap()
In-Reply-To: <20170425182549.GA18677@e104818-lin.cambridge.arm.com>
References: <1493144543-2497-1-git-send-email-catalin.marinas@arm.com>
 <20170425182549.GA18677@e104818-lin.cambridge.arm.com>
Message-ID: <20170428161411.GA26277@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 07:25:49PM +0100, Catalin Marinas wrote:
> On Tue, Apr 25, 2017 at 07:22:23PM +0100, Catalin Marinas wrote:
> > The dma_common_pages_remap() function allocates a vm_struct object and
> > initialises the pages pointer to value passed as argument. However, when
> > this function is called dma_common_contiguous_remap(), the pages array
> > is only temporarily allocated, being freed shortly after
> > dma_common_contiguous_remap() returns. Architecture code checking the
> > validity of an area->pages pointer would incorrectly dereference already
> > freed pointers. This has been exposed by the arm64 commit 44176bb38fa4
> > ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU").
> > 
> > Fixes: 513510ddba96 ("common: dma-mapping: introduce common remapping functions")
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Small correction on the subject, the prefix should be something like:
> 
> drivers: dma-mapping:
> 
> It's not an arm64 patch.

If you want to take it through your tree:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
otherwise feel free to resend it with a fixed subject line and I can
take it :)

thanks,

greg k-h
