From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 5 May 2015 09:27:54 +0100
Subject: [PATCH 1/4] video: backlight: da9052: Constify platform_device_id
In-Reply-To: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150505082754.GU4047@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 02 May 2015, Krzysztof Kozlowski wrote:

> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/video/backlight/da9052_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
> index b1943e7735a1..fd2be417aa64 100644
> --- a/drivers/video/backlight/da9052_bl.c
> +++ b/drivers/video/backlight/da9052_bl.c
> @@ -152,7 +152,7 @@ static int da9052_backlight_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_device_id da9052_wled_ids[] = {
> +static const struct platform_device_id da9052_wled_ids[] = {
>  	{
>  		.name		= "da9052-wled1",
>  		.driver_data	= DA9052_TYPE_WLED1,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
