From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Oct 2014 16:42:35 +0200
Subject: [PATCH v2 2/4] regulator: Set ena_gpio_initialized in regulator
 drivers
In-Reply-To: <1412776028-15655-3-git-send-email-mpa@pengutronix.de>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
 <1412776028-15655-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20141013144235.GJ27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 03:47:06PM +0200, Markus Pargmann wrote:

> --- a/drivers/regulator/max8952.c
> +++ b/drivers/regulator/max8952.c
> @@ -225,6 +225,8 @@ static int max8952_pmic_probe(struct i2c_client *client,
>  	config.of_node = client->dev.of_node;
>  
>  	config.ena_gpio = pdata->gpio_en;
> +	if (!pdata)
> +		config.ena_gpio_initialized = true;

This looks wrong, we're checking for pdata being non-NULL immediately
after dereferencing pdata.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/646707a5/attachment.sig>
