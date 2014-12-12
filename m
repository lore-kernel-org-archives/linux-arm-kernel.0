From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Dec 2014 13:23:21 +0000
Subject: [PATCH 1/3] ASoC: codecs: wm8904: add dt ids table
In-Reply-To: <1418267681-4091-1-git-send-email-voice.shen@atmel.com>
References: <1418267681-4091-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20141212132321.GI11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 11:14:39AM +0800, Bo Shen wrote:

> +static const struct of_device_id wm8904_of_match[] = {
> +	{ .compatible = "wlf,wm8904", },
> +	{ .compatible = "wlf,wm8912", },
> +	{ .compatible = "wlf,wm8918", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, wm8904_of_match);
> +
>  static struct i2c_driver wm8904_i2c_driver = {
>  	.driver = {
>  		.name = "wm8904",
>  		.owner = THIS_MODULE,
> +		.of_match_table = wm8904_of_match,

I'm not seeing anything here that ensures that devtype is set correctly
when probing using the OF IDs - currently we rely on i2c->driver_data.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/d2eece05/attachment.sig>
