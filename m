From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 04 May 2015 16:47:24 +0900
Subject: [PATCH] drm/exynos: mixer: Constify platform_device_id
In-Reply-To: <1430495796-32016-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495796-32016-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <5547240C.3090107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 05? 02? 00:56, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied.

Thanks,
Inki Dae

> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index fbec750574e6..512549a35e96 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -1156,7 +1156,7 @@ static struct mixer_drv_data exynos4210_mxr_drv_data = {
>  	.has_sclk = 1,
>  };
>  
> -static struct platform_device_id mixer_driver_types[] = {
> +static const struct platform_device_id mixer_driver_types[] = {
>  	{
>  		.name		= "s5p-mixer",
>  		.driver_data	= (unsigned long)&exynos4210_mxr_drv_data,
> 
