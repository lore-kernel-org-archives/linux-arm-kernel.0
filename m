From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 30 May 2017 11:32:13 +0200
Subject: [PATCH v6 1/6] iommu: of: Fix check for returning EPROBE_DEFER
In-Reply-To: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
References: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170530093212.GD2818@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 07:17:40PM +0530, Sricharan R wrote:
> Now with IOMMU probe deferral, we return -EPROBE_DEFER
> for masters that are connected to an IOMMU which is not
> probed yet, but going to get probed, so that we can attach
> the correct dma_ops. So while trying to defer the probe of
> the master, check if the of_iommu node that it is connected
> to is marked in DT as 'status=disabled', then the IOMMU is never
> is going to get probed. So simply return NULL and let the master
> work without an IOMMU.
> 
> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Magnus Damn <magnus.damn@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/of_iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Sorry for the confusion, I meant to apply this version of the patch-set
instead of v5.
