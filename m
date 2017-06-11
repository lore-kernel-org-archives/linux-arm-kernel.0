From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Sat, 10 Jun 2017 22:36:44 -0400
Subject: [PATCH 07/44] xen-swiotlb: consolidate xen_swiotlb_dma_ops
In-Reply-To: <20170608132609.32662-8-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-8-hch@lst.de>
Message-ID: <20170611023644.GE30966@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:25:32PM +0200, Christoph Hellwig wrote:
> ARM and x86 had duplicated versions of the dma_ops structure, the
> only difference is that x86 hasn't wired up the set_dma_mask,
> mmap, and get_sgtable ops yet.  On x86 all of them are identical
> to the generic version, so they aren't needed but harmless.
> 
> All the symbols used only for xen_swiotlb_dma_ops can now be marked
> static as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/xen/mm.c              | 17 --------
>  arch/x86/xen/pci-swiotlb-xen.c | 14 -------
>  drivers/xen/swiotlb-xen.c      | 93 ++++++++++++++++++++++--------------------
>  include/xen/swiotlb-xen.h      | 62 +---------------------------
>  4 files changed, 49 insertions(+), 137 deletions(-)

Yeeey!

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
