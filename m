From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 30 Jul 2014 14:52:16 +0200
Subject: [PATCH 3/4] gpio: pca953x: Add pca9506 as DT compatible
In-Reply-To: <1406618686-22385-4-git-send-email-mpa@pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
 <1406618686-22385-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20140730125216.GI13842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 09:24:45AM +0200, Markus Pargmann wrote:
> This driver can also be used for the nxp,pca9506 device.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
>  drivers/gpio/gpio-pca953x.c                             | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> index b9a42f294dd0..eb65157d47f6 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>   - compatible: Has to contain one of the following:
>  	nxp,pca9505
> +	nxp,pca9506
>  	nxp,pca9534
>  	nxp,pca9535
>  	nxp,pca9536
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index fda3eae835d0..df5eb6e6be1e 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -729,6 +729,7 @@ static int pca953x_remove(struct i2c_client *client)
>  
>  static const struct of_device_id pca953x_dt_ids[] = {
>  	{ .compatible = "nxp,pca9505", },
> +	{ .compatible = "nxp,pca9506", },

The item for the i2c_device_id table is missing in this patch. I will
send a v2.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/1c493698/attachment.sig>
