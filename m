From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 5 May 2015 09:28:35 +0100
Subject: [PATCH 4/4] video: fbdev: s3c-fb: Constify platform_device_id
In-Reply-To: <1430494721-30793-4-git-send-email-k.kozlowski.k@gmail.com>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-4-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150505082835.GX4047@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 02 May 2015, Krzysztof Kozlowski wrote:

> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/video/fbdev/s3c-fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
> index 7e3a05fc47aa..f72dd12456f9 100644
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1938,7 +1938,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
>  	},
>  };
>  
> -static struct platform_device_id s3c_fb_driver_ids[] = {
> +static const struct platform_device_id s3c_fb_driver_ids[] = {
>  	{
>  		.name		= "s3c-fb",
>  		.driver_data	= (unsigned long)&s3c_fb_data_64xx,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
