From: jroedel@suse.de (Joerg Roedel)
Date: Tue, 5 May 2015 15:19:29 +0200
Subject: [PATCH] iommu: rockchip: fix build without CONFIG_OF
In-Reply-To: <3138014.xYAj3FssJ8@wuerfel>
References: <3138014.xYAj3FssJ8@wuerfel>
Message-ID: <20150505131929.GE5438@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:58:24PM +0200, Arnd Bergmann wrote:
> The rockchip iommu driver references its of_device_id table
> from the init function, which fails to build when the table
> is undefined:
> 
> iommu/rockchip-iommu.c: In function 'rk_iommu_init':
> iommu/rockchip-iommu.c:1029:35: error: 'rk_iommu_dt_ids' undeclared (first use in this function)
>   np = of_find_matching_node(NULL, rk_iommu_dt_ids);
> 
> This removes the #ifdef and the corresponding of_match_ptr wrapper
> to make it build both with CONFIG_OF enabled or disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 425061b0f5074 ("iommu/rockchip: Play nice in multi-platform builds")

Applied to iommu/fixes, thanks.
