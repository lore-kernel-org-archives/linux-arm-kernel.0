From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 04 Jun 2013 12:59:11 +0900
Subject: [PATCH 05/10] mmc: dw_mmc-pltfm: remove static from
 dw_mci_pltfm_remove
In-Reply-To: <201306030058.27184.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030058.27184.heiko@sntech.de>
Message-ID: <51AD660F.7060508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 06/03/2013 07:58 AM, Heiko St?bner wrote:
> dw_mci_pltfm_remove gets exported and used by dw_mmc-exynos, so should
> not be static.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 37873f1..0048da8 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -68,7 +68,7 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
>  	return dw_mci_pltfm_register(pdev, NULL);
>  }
>  
> -static int dw_mci_pltfm_remove(struct platform_device *pdev)
> +int dw_mci_pltfm_remove(struct platform_device *pdev)
>  {
>  	struct dw_mci *host = platform_get_drvdata(pdev);
>  
> 
