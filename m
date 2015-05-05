From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 5 May 2015 09:28:20 +0100
Subject: [PATCH 3/4] video: fbdev: mxsfb: Constify platform_device_id
In-Reply-To: <1430494721-30793-3-git-send-email-k.kozlowski.k@gmail.com>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-3-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150505082820.GW4047@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 02 May 2015, Krzysztof Kozlowski wrote:

> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/video/fbdev/mxsfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> index f8ac4a452f26..497971c82bb1 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -814,7 +814,7 @@ static void mxsfb_free_videomem(struct mxsfb_info *host)
>  	free_pages_exact(fb_info->screen_base, fb_info->fix.smem_len);
>  }
>  
> -static struct platform_device_id mxsfb_devtype[] = {
> +static const struct platform_device_id mxsfb_devtype[] = {
>  	{
>  		.name = "imx23-fb",
>  		.driver_data = MXSFB_V3,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
