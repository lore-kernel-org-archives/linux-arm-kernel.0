From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Nov 2018 17:49:50 +0000
Subject: [PATCH] arm64: hide unused swiotlb functions
In-Reply-To: <20181102152624.1189250-1-arnd@arndb.de>
References: <20181102152624.1189250-1-arnd@arndb.de>
Message-ID: <20181102174949.GJ218059@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 04:26:07PM +0100, Arnd Bergmann wrote:
> After a good chunk of the swiotlb code has been replaced with the generic
> version, two functions are only used from inside of an #ifdef:
> 
> arch/arm64/mm/dma-mapping.c:174:12: error: '__swiotlb_mmap_pfn' defined but not used [-Werror=unused-function]
>  static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>             ^~~~~~~~~~~~~~~~~~
> arch/arm64/mm/dma-mapping.c:163:12: error: '__swiotlb_get_sgtable_page' defined but not used [-Werror=unused-function]
>  static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> 
> Move them into the same #ifdef section to avoid that warning.
> 
> Fixes: 886643b76632 ("arm64: use the generic swiotlb_dma_ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Christoph already proposed a fix here:

https://marc.info/?l=linux-arm-kernel&m=154091441602535

-- 
Catalin
