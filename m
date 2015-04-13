From: treding@nvidia.com (Thierry Reding)
Date: Mon, 13 Apr 2015 12:10:53 +0200
Subject: [PATCH] iommu: rockchip: fix build without CONFIG_OF
In-Reply-To: <3138014.xYAj3FssJ8@wuerfel>
References: <3138014.xYAj3FssJ8@wuerfel>
Message-ID: <20150413101050.GA3654@ulmo.nvidia.com>
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

How can this even happen? Rockchip depends on multiplatform, and
multiplatform pulls in OF. Ah... COMPILE_TEST... oh well.

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150413/14d922ea/attachment.sig>
