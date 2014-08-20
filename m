From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Wed, 20 Aug 2014 10:33:07 +0530
Subject: [PATCH] thermal: exynos: Remove duplicate code when reading
 triminfo register of Exynos5440
In-Reply-To: <1408508673-3173-1-git-send-email-cw00.choi@samsung.com>
References: <1408450078-6296-1-git-send-email-cw00.choi@samsung.com>
 <1408508673-3173-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CADGdYn7rfS8fa-iCw_gu-sEQEHaUV_ZOPc03SEdv0qEqLQa10Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 9:54 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch remove simply duplicate code when reading triminfo register of Exynos5440.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Thanks,
Amit
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index ed01606..13c2e01 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -181,15 +181,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>                  */
>                 switch (data->id) {
>                 case 0:
> +               case 2:
>                         trim_info = readl(data->base +
>                         EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
>                         break;
>                 case 1:
>                         trim_info = readl(data->base + reg->triminfo_data);
>                         break;
> -               case 2:
> -                       trim_info = readl(data->base -
> -                       EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
>                 }
>         } else {
>                 /* On exynos5420 the triminfo register is in the shared space */
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
