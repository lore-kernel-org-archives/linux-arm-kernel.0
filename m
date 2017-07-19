From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 19 Jul 2017 11:58:04 +0100
Subject: [PATCH 1/5] iommu: Add capability IOMMU_CAP_BYPASS
In-Reply-To: <1500456838-18405-2-git-send-email-anup.patel@broadcom.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <1500456838-18405-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <675744d3-b070-1245-6ebc-579c4b5f4a75@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/17 10:33, Anup Patel wrote:
> Some of the IOMMUs (such as ARM SMMU) are capable of bypassing
> transactions for which no IOMMU domain is configured.
> 
> This patch adds IOMMU_CAP_BYPASS which can be used by IOMMU
> drivers to advertise transation bypass capability of an IOMMU.

Whatever the intended semantics of this are, I can't help thinking it
would be better served by allowing callers to explicitly allocate their
own IOMMU_DOMAIN_IDENTITY domains. That would also be useful for the
problem we have with legacy virtio devices behind real IOMMUs.

Robin.

> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  include/linux/iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 2cb54ad..6bbb4cc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -101,6 +101,10 @@ enum iommu_cap {
>  					   transactions */
>  	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>  	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> +	IOMMU_CAP_BYPASS,		/*
> +					 * IOMMU can bypass transactions for
> +					 * which domain is not configured
> +					 */
>  };
>  
>  /*
> 
