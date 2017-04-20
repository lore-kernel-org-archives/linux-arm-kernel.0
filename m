From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Thu, 20 Apr 2017 09:50:23 +0530
Subject: [PATCH] iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU is
 bypassed
In-Reply-To: <1492430246-17267-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1492430246-17267-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <CA+sq2Cdf8OOUmM_PU+b5T5G6mRRxJb1e4UZnx60bbqwJUY20Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 5:27 PM,  <sunil.kovvuri@gmail.com> wrote:
> From: Sunil Goutham <sgoutham@cavium.com>
>
> For software initiated address translation, when domain type is
> IOMMU_DOMAIN_IDENTITY i.e SMMU is bypassed, mimic HW behavior
> i.e return the same IOVA as translated address.
>
> This patch is an extension to Will Deacon's patchset
> "Implement SMMU passthrough using the default domain".
>
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> ---
>  drivers/iommu/arm-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 41afb07..2f4a130 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1405,6 +1405,9 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>         struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
>
> +       if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +               return iova;
> +
>         if (!ops)
>                 return 0;
>
> --
> 2.7.4
>

Any comments or is this patch accepted ?

Thanks,
Sunil.
