From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 25 May 2017 15:30:42 +0200
Subject: [PATCH v2] drivers: dma-mapping: Do not leave an invalid
 area->pages pointer in dma_common_contiguous_remap()
In-Reply-To: <1493823468-19470-1-git-send-email-catalin.marinas@arm.com>
References: <1493823468-19470-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20170525133042.GA17464@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 03:57:48PM +0100, Catalin Marinas wrote:
> The dma_common_pages_remap() function allocates a vm_struct object and
> initialises the pages pointer to value passed as argument. However, when
> this function is called dma_common_contiguous_remap(), the pages array
> is only temporarily allocated, being freed shortly after
> dma_common_contiguous_remap() returns. Architecture code checking the
> validity of an area->pages pointer would incorrectly dereference already
> freed pointers. This has been exposed by the arm64 commit 44176bb38fa4
> ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU").
> 
> Fixes: 513510ddba96 ("common: dma-mapping: introduce common remapping functions")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Laura Abbott <labbott@redhat.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> Greg,
> 
> Please merge this patch via your tree (and therefore I haven't added
> your ack). Thanks.

I just tried to, but it doesn't apply to 4.12-rc2 :(

Can you refresh this and resend?

thanks,

greg k-h
