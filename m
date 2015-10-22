From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 22 Oct 2015 09:06:52 +0900
Subject: [PATCH 1/2] mmc: dw_mmc: exynos: Add the exynos3250 compatible
In-Reply-To: <1445409555-1684-1-git-send-email-jh80.chung@samsung.com>
References: <1445409555-1684-1-git-send-email-jh80.chung@samsung.com>
Message-ID: <5628289C.90800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.10.2015 15:39, Jaehoon Chung wrote:
> To check more exactly, add the exynos3250 compatible.
> Not use exynos5250 compatibility.

Hi,

I can't find any difference between old and new compatible. Maybe I am
missing something? Maybe there is a difference for these devices?

Anyway if the code is the same then it should use exactly the same
compatible.

Best regards,
Krzysztof

> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
>  drivers/mmc/host/dw_mmc-exynos.c                         | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index aad9844..cd22ac9 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -22,6 +22,8 @@ Required Properties:
>  	  specific extensions.
>  	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
>  	  specific extensions having an SMU.
> +	- "samsung,exynos3250-dw-mshc": for controllers with Samsung Exynos3250
> +	  specific extensions.
>  
>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
>    unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 1e75309..1c96218 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -32,6 +32,7 @@ enum dw_mci_exynos_type {
>  	DW_MCI_TYPE_EXYNOS5420_SMU,
>  	DW_MCI_TYPE_EXYNOS7,
>  	DW_MCI_TYPE_EXYNOS7_SMU,
> +	DW_MCI_TYPE_EXYNOS3250,
>  };
>  
>  /* Exynos implementation specific driver private data */
> @@ -73,6 +74,9 @@ static struct dw_mci_exynos_compatible {
>  	}, {
>  		.compatible	= "samsung,exynos7-dw-mshc-smu",
>  		.ctrl_type	= DW_MCI_TYPE_EXYNOS7_SMU,
> +	}, {
> +		.compatible	= "samsung,exynos3250-dw-mshc",
> +		.ctrl_type	= DW_MCI_TYPE_EXYNOS3250,
>  	},
>  };
>  
> @@ -467,6 +471,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
>  	} while (start_smpl != smpl);
>  
>  	found = dw_mci_exynos_get_best_clksmpl(candiates);
> +
>  	if (found >= 0) {
>  		dw_mci_exynos_set_clksmpl(host, found);
>  		priv->tuned_sample = found;
> @@ -520,6 +525,8 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>  			.data = &exynos_drv_data, },
>  	{ .compatible = "samsung,exynos7-dw-mshc-smu",
>  			.data = &exynos_drv_data, },
> +	{ .compatible = "samsung,exynos3250-dw-mshc",
> +			.data = &exynos_drv_data, },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
> 
