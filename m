From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Jun 2013 09:41:42 -0700
Subject: [PATCH/RESEND 06/12] msm: iommu: Use clk_set_rate() instead of
 clk_set_min_rate()
In-Reply-To: <1371490999-15501-7-git-send-email-sboyd@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
 <1371490999-15501-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130620164142.GD6300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sending to correct Joerg address.

On 06/17, Stephen Boyd wrote:
> Calling clk_set_min_rate() is no better than just calling
> clk_set_rate() because MSM clock code already takes care of
> calling the min_rate ops if the clock really needs
> clk_set_min_rate() called on it.
> 
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/iommu/msm_iommu_dev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
> index d344f6a..9144a6b 100644
> --- a/drivers/iommu/msm_iommu_dev.c
> +++ b/drivers/iommu/msm_iommu_dev.c
> @@ -29,7 +29,6 @@
>  
>  #include <mach/iommu_hw-8xxx.h>
>  #include <mach/iommu.h>
> -#include <mach/clk.h>
>  
>  struct iommu_ctx_iter_data {
>  	/* input */
> @@ -168,7 +167,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  
>  	if (!IS_ERR(iommu_clk))	{
>  		if (clk_get_rate(iommu_clk) == 0)
> -			clk_set_min_rate(iommu_clk, 1);
> +			clk_set_rate(iommu_clk, 1);
>  
>  		ret = clk_prepare_enable(iommu_clk);
>  		if (ret) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
