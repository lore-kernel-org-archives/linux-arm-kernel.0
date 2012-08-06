From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Aug 2012 12:30:34 +0300
Subject: [PATCH] driver: misc: bmp085: remove "of_match_table" property.
In-Reply-To: <1344245324-16704-1-git-send-email-sourav.poddar@ti.com>
References: <1344245324-16704-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120806093033.GH17551@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 02:58:44PM +0530, Sourav Poddar wrote:
> There is an automatic binding done for I2C devices in the of_i2c core
> code. So, DT will be able to bind to any I2C device using the
> already existing table: MODULE_DEVICE_TABLE(i2c, bmp085_id).
> 
> Tested on omap5430 evm.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/misc/bmp085-i2c.c |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/bmp085-i2c.c b/drivers/misc/bmp085-i2c.c
> index 9943971..a4f33c9 100644
> --- a/drivers/misc/bmp085-i2c.c
> +++ b/drivers/misc/bmp085-i2c.c
> @@ -57,12 +57,6 @@ static int bmp085_i2c_remove(struct i2c_client *client)
>  	return bmp085_remove(&client->dev);
>  }
>  
> -static const struct of_device_id bmp085_of_match[] = {
> -	{ .compatible = "bosch,bmp085", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, bmp085_of_match);
> -
>  static const struct i2c_device_id bmp085_id[] = {
>  	{ BMP085_NAME, 0 },
>  	{ "bmp180", 0 },
> @@ -74,7 +68,6 @@ static struct i2c_driver bmp085_i2c_driver = {
>  	.driver = {
>  		.owner	= THIS_MODULE,
>  		.name	= BMP085_NAME,
> -		.of_match_table = bmp085_of_match
>  	},
>  	.id_table	= bmp085_id,
>  	.probe		= bmp085_i2c_probe,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120806/727e0910/attachment.sig>
