From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Nov 2014 18:44:46 +0000
Subject: [PATCH v8 0/13] introduce GNTTABOP_cache_flush
In-Reply-To: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
Message-ID: <20141110184446.GJ25609@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 04:12:40PM +0000, Stefano Stabellini wrote:
> this patch series introduces support for GNTTABOP_cache_flush to perform
> cache maintenance operation on foreign pages and reverts the current
> code based on XENFEAT_grant_map_identity.
> 
> It also provides a very slow fallback by bouncing on the swiotlb buffer,
> in case the hypercall is not available.
> 
> v7 introduces a flag named dma_coherent in dev_archdata and an accessor
> function named is_device_dma_coherent in asm/dma-mapping.h under arm and
> arm64.

Apart from a few minor comments I gave already, the series looks fine to
me. Once addressed, you can add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
