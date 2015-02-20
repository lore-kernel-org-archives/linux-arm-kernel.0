From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 20 Feb 2015 14:16:27 +0200
Subject: [PATCH] video: fbdev: make of_device_id array const
In-Reply-To: <1423479747-17899-1-git-send-email-sanjeev_sharma@mentor.com>
References: <1423479747-17899-1-git-send-email-sanjeev_sharma@mentor.com>
Message-ID: <54E7259B.7080101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/15 13:02, Sanjeev Sharma wrote:
> Make of_device_id array const.
> 
> Signed-off-by: Sanjeev Sharma <Sanjeev_Sharma@mentor.com>
> ---
>  drivers/video/fbdev/imxfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 3b6a3c8..84d1d29 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -183,7 +183,7 @@ static struct platform_device_id imxfb_devtype[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, imxfb_devtype);
>  
> -static struct of_device_id imxfb_of_dev_id[] = {
> +static const struct of_device_id imxfb_of_dev_id[] = {
>  	{
>  		.compatible = "fsl,imx1-fb",
>  		.data = &imxfb_devtype[IMX1_FB],
> 

Thanks, queued for 3.21.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150220/d99b0c51/attachment.sig>
