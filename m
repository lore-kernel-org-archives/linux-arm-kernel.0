From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jul 2014 14:56:40 +0100
Subject: [PATCHv4 0/5] Atomic pool for arm64
In-Reply-To: <1406079308-5232-1-git-send-email-lauraa@codeaurora.org>
References: <1406079308-5232-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140724135640.GD13371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 02:35:03AM +0100, Laura Abbott wrote:
> Laura Abbott (5):
>   lib/genalloc.c: Add power aligned algorithm
>   lib/genalloc.c: Add genpool range check function
>   common: dma-mapping: Introduce common remapping functions
>   arm: use genalloc for the atomic pool
>   arm64: Add atomic pool for non-coherent and CMA allocations.

The only thing left is the removal of unmap_kernel_range() call in
dma_common_free_remap() (vunmap is enough). Feel free to add my review
to the whole series:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
