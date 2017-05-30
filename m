From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 30 May 2017 11:27:59 +0200
Subject: [PATCH v5 1/5] iommu: of: Fix check for returning EPROBE_DEFER
In-Reply-To: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
References: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170530092759.GC2818@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 06:31:29PM +0530, Sricharan R wrote:
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
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Magnus Damn <magnus.damn@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Applied all to iommu/fixes, thanks.
