From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Mon, 9 Dec 2013 16:50:57 +0000
Subject: [PATCH] xen/arm64: do not call the swiotlb functions twice
In-Reply-To: <1386605160-3185-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1386605160-3185-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1386607857.7812.66.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-09 at 16:06 +0000, Stefano Stabellini wrote:
> On arm64 the dma_map_ops implementation is based on the swiotlb.
> swiotlb-xen, used by default in dom0 on Xen, is also based on the
> swiotlb.
> 
> Avoid calling into the default arm64 dma_map_ops functions from
> xen_dma_map_page, xen_dma_unmap_page, xen_dma_sync_single_for_cpu, and
> xen_dma_sync_single_for_device otherwise we end up calling into the
> swiotlb twice.
> 
> When arm64 gets a non-swiotlb based implementation of dma_map_ops, we'll
> probably have to reintroduce dma_map_ops calls in page-coherent.h.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: catalin.marinas at arm.com
> CC: Will.Deacon at arm.com

Tested-by: Ian Campbell <ian.campbell@citrix.com>

Ian.
