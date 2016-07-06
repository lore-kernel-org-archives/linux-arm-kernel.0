From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 06 Jul 2016 09:12:18 +0900
Subject: [PATCH] memory: samsung: exynos-srom: fix wrong count of registers
In-Reply-To: <1467718817-19239-1-git-send-email-sw0312.kim@samsung.com>
References: <CGME20160705114058epcas1p103f3f6d7cd39bf6d99f36f0fea2493f0@epcas1p1.samsung.com>
 <1467718817-19239-1-git-send-email-sw0312.kim@samsung.com>
Message-ID: <577C4CE2.2090103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 07? 05? 20:40, Seung-Woo Kim wrote:
> This patch fixes wrong count of array for srom registers from probe
> function.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  drivers/memory/samsung/exynos-srom.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
> index 96756fb..c66d2bd 100644
> --- a/drivers/memory/samsung/exynos-srom.c
> +++ b/drivers/memory/samsung/exynos-srom.c
> @@ -134,7 +134,7 @@ static int exynos_srom_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, srom);
>  
>  	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
> -			sizeof(exynos_srom_offsets));
> +			ARRAY_SIZE(exynos_srom_offsets));
>  	if (!srom->reg_offset) {
>  		iounmap(srom->reg_base);
>  		return -ENOMEM;
> 

On the exynos-srom.c, use the ARRAY_SIZE to get the number of array entry.
Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
