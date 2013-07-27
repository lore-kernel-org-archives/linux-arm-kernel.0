From: broonie@kernel.org (Mark Brown)
Date: Sat, 27 Jul 2013 12:59:50 +0100
Subject: [PATCH v10 2/7] ASoC: codec: wm9712 simple DT bindings
In-Reply-To: <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20130727115950.GF9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 01:31:51PM +0200, Markus Pargmann wrote:

> +static const struct of_device_id wm9712_codec_of_dev_id[] = {
> +	{
> +		.compatible = "wlf,wm9712",
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
>  static struct platform_driver wm9712_codec_driver = {
>  	.driver = {
>  		.name = "wm9712-codec",
>  		.owner = THIS_MODULE,
> +		.of_match_table = wm9712_codec_of_dev_id,
>  	},
>  
>  	.probe = wm9712_probe,

AC'97 is an enumerable bus, we shouldn't need this...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130727/5c73c832/attachment-0001.sig>
