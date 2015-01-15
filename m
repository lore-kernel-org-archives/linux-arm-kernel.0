From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Jan 2015 11:54:25 +0000
Subject: [PATCH v2 1/3] ASoC: codecs: wm8904: add dt ids table
In-Reply-To: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20150115115425.GX3043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 11:31:11AM +0800, Bo Shen wrote:

> +#ifdef CONFIG_OF
> +static enum wm8904_type wm8904_data = WM8904;
> +static enum wm8904_type wm8912_data = WM8912;
> +
> +static const struct of_device_id wm8904_of_match[] = {
> +	{
> +		.compatible = "wlf,wm8904",
> +		.data = &wm8904_data,

Does this end up in the i2c_driver_id driver data or do we need some
extra code when devtype is assigned to check for an of_node and look at
the DT data instead?  That certainly used to be the case...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/3e474574/attachment.sig>
