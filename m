From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 23 Sep 2010 21:40:21 +0200
Subject: [RESEND PATCH] serial: samsung: fix device name
In-Reply-To: <20100923190212.18863.25678.stgit@darius-desktop>
References: <20100923190212.18863.25678.stgit@darius-desktop>
Message-ID: <20100923194021.GA11663@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 10:15:31PM +0300, Darius Augulis wrote:
> Swap device and driver names in serial/samsung.c
> 
> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> ---
> 
> This patch was submitted about 3 months ago, but still not merged.
> There was another similar patch from Joonyoung Shim
> <jy0922.shim@samsung.com> and was discussed here:
> http://marc.info/?l=linux-serial&m=127416101222281&w=2.
> Joonyoung Shim acked my patch and other people on ARM mailing list
> acked it. The maintainer, Ben Dooks, still not responding for

Why didn't you add the ACKs to your patch? That will look more convincing for
the one picking it up.

> a long time. Another maintainer, Kukjin Kim, refused to merge
> it without Ben's review.
> I would like to ask somebody pick up this bugfix.
> 
>  drivers/serial/samsung.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> index b1156ba..25c0d0f 100644
> --- a/drivers/serial/samsung.c
> +++ b/drivers/serial/samsung.c
> @@ -883,10 +883,10 @@ static struct uart_ops s3c24xx_serial_ops = {
>  
>  static struct uart_driver s3c24xx_uart_drv = {
>  	.owner		= THIS_MODULE,
> -	.dev_name	= "s3c2410_serial",
> +	.driver_name    = "s3c2410_serial",
>  	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
>  	.cons		= S3C24XX_SERIAL_CONSOLE,
> -	.driver_name	= S3C24XX_SERIAL_NAME,
> +	.dev_name       = S3C24XX_SERIAL_NAME,
>  	.major		= S3C24XX_SERIAL_MAJOR,
>  	.minor		= S3C24XX_SERIAL_MINOR,
>  };
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100923/8360039e/attachment.sig>
