From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 25 Oct 2016 22:18:52 +0200 (CEST)
Subject: [PATCH 3/3] drivers: iommu: io-pgtable-arm: use const and
 __initconst for iommu_gather_ops structures
In-Reply-To: <1477418772-12184-4-git-send-email-bhumirks@gmail.com>
References: <1477418772-12184-1-git-send-email-bhumirks@gmail.com>
 <1477418772-12184-4-git-send-email-bhumirks@gmail.com>
Message-ID: <alpine.DEB.2.20.1610252218290.2062@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 25 Oct 2016, Bhumika Goyal wrote:

> Check for iommu_gather_ops structures that are only stored in the tlb
> field of an io_pgtable_cfg structure. The tlb field is of type
> const struct iommu_gather_ops *, so iommu_gather_ops structures
> having this property can be declared as const. Also, replace __initdata
> with __initconst.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5c90e1..412e21d 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -916,7 +916,7 @@ static void dummy_tlb_sync(void *cookie)
>  	WARN_ON(cookie != cfg_cookie);
>  }
>
> -static struct iommu_gather_ops dummy_tlb_ops __initdata = {
> +static const struct iommu_gather_ops dummy_tlb_ops __initconst = {
>  	.tlb_flush_all	= dummy_tlb_flush_all,
>  	.tlb_add_flush	= dummy_tlb_add_flush,
>  	.tlb_sync	= dummy_tlb_sync,
> --
> 1.9.1
>
>
