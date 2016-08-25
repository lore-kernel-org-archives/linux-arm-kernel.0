From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 25 Aug 2016 09:12:44 +0200
Subject: [PATCH v3 5/5] gpu: drm: exynos_hdmi: Remove duplicate
 initialization of regulator bulk consumer
In-Reply-To: <1472044039-16536-6-git-send-email-woogyom.kim@gmail.com>
References: <1472044039-16536-1-git-send-email-woogyom.kim@gmail.com>
 <1472044039-16536-6-git-send-email-woogyom.kim@gmail.com>
Message-ID: <cd131b95-97f4-7ad0-8130-9a2000312bd9@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2016 03:07 PM, Milo Kim wrote:
> The helper, devm_regulator_bulk_get() initializes the consumer as NULL,
> so this code can be ignored.
>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
--
Regards
Andrzej
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 249cb23..4e17877f 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1669,10 +1669,9 @@ static int hdmi_resources_init(struct hdmi_context *hdata)
>  	if (ret)
>  		return ret;
>  
> -	for (i = 0; i < ARRAY_SIZE(supply); ++i) {
> +	for (i = 0; i < ARRAY_SIZE(supply); ++i)
>  		hdata->regul_bulk[i].supply = supply[i];
> -		hdata->regul_bulk[i].consumer = NULL;
> -	}
> +
>  	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(supply), hdata->regul_bulk);
>  	if (ret) {
>  		if (ret != -EPROBE_DEFER)
