From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Apr 2017 15:21:26 +0100
Subject: [PATCH 1/2] xen/arm, arm64: fix xen_dma_ops after 815dd18
 "Consolidate get_dma_ops..."
In-Reply-To: <1492117462-19886-1-git-send-email-sstabellini@kernel.org>
References: <1492117462-19886-1-git-send-email-sstabellini@kernel.org>
Message-ID: <20170418142126.GE27592@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 02:04:21PM -0700, Stefano Stabellini wrote:
> The following commit:
> 
>   commit 815dd18788fe0d41899f51b91d0560279cf16b0d
>   Author: Bart Van Assche <bart.vanassche@sandisk.com>
>   Date:   Fri Jan 20 13:04:04 2017 -0800
> 
>       treewide: Consolidate get_dma_ops() implementations
> 
> rearranges get_dma_ops in a way that xen_dma_ops are not returned when
> running on Xen anymore, dev->dma_ops is returned instead (see
> arch/arm/include/asm/dma-mapping.h:get_arch_dma_ops and
> include/linux/dma-mapping.h:get_dma_ops).
> 
> Fix the problem by storing dev->dma_ops in dev_archdata, and setting
> dev->dma_ops to xen_dma_ops. This way, xen_dma_ops is returned naturally
> by get_dma_ops. The Xen code can retrieve the original dev->dma_ops from
> dev_archdata when needed. It also allows us to remove __generic_dma_ops
> from common headers.
> 
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Julien Grall <julien.grall@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> CC: linux at armlinux.org.uk
> CC: catalin.marinas at arm.com
> CC: will.deacon at arm.com
> CC: boris.ostrovsky at oracle.com
> CC: jgross at suse.com
> CC: Julien Grall <julien.grall@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
